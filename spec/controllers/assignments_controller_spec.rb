require 'rails_helper'

describe AssignmentsController do
  let!(:event) { FactoryBot.create(:event) }
  let!(:task) { FactoryBot.create(:task, event_id: event.id)}
  context "as a volunteer" do

    before :each do
      setup_controller_for_warden
      request.env['devise.mapping'] = Devise.mappings[:volunteer]
    end

    login_volunteer

    describe "#new" do
      it "creates a new assignment called @assignment" do
        get :new, params: { event_id: event.id, task_id: task.id }
        expect(assigns(:assignment)).not_to be_nil
        expect(assigns(:assignment)).to be_a_new(Assignment)
      end
      it "does not allow duplicate assignments" do
        FactoryBot.create(:assignment, volunteer_id: @volunteer.id )
        get :new, params: { event_id: event.id, task_id: event.id}
        expect(assigns(:assignment)).not_to be_a_new(Assignment)
      end
    end

    describe "#create" do
      it "adds an assignment" do
        expect { post :create, params: { assignment: FactoryBot.attributes_for(:assignment), event_id: event.id, task_id: task.id }
        }.to change { Assignment.count }.by(1)
      end
      it "does not add an existing assignment" do
        FactoryBot.create(:assignment, volunteer_id: @volunteer.id)
        expect { post :create, params: { assignment: FactoryBot.attributes_for(:assignment), event_id: event.id, task_id: task.id }
        }.to change { Assignment.count }.by(0)
      end
      context "assignment" do
        let!(:test_assignment) { FactoryBot.create(:assignment, task_id: task.id, volunteer_id: @volunteer.id)}
        it 'creates reminder job' do
            ActiveJob::Base.queue_adapter = :test
            expect { RemindersMailer.remind_task(test_assignment.volunteer, task).deliver_later
            }.to have_enqueued_job.on_queue('mailers')
        end
      end
    end

    describe "#destroy" do
      let!(:assignment) { FactoryBot.create(:assignment, volunteer_id: @volunteer.id, task_id: task.id) }
      let!(:other_volunteer) { FactoryBot.create(:other_volunteer) }
      let!(:other_assign) { FactoryBot.create(:assignment, volunteer_id: other_volunteer.id, task_id: task.id) }

      it "can delete their own assignment" do
        expect { delete :destroy, params: { id: assignment.id, event_id: event.id, task_id: task.id}
        }.to change { Assignment.count }.by(-1)
      end

      it "cannot delete another assignment" do
        expect { delete :destroy, params: { id: other_assign.id, event_id: event.id, task_id: task.id}
        }.to change { Assignment.count }.by(0)
      end
    end
  end

  context "as an admin" do

    before :each do
      setup_controller_for_warden
      request.env['devise.mapping'] = Devise.mappings[:admin]
    end

    login_admin

    describe "#destroy" do
      let!(:volunteer) { FactoryBot.create(:volunteer) }
      let!(:assignment) { FactoryBot.create(:assignment, volunteer_id: volunteer.id, task_id: task.id) }

      it "deletes an assignment" do
        expect { delete :destroy, params: { id: assignment.id, event_id: event.id, task_id: task.id}
        }.to change { Assignment.count }.by(-1)
      end

      context "task for the assignment is deleted" do
        it "deletes associated assignments" do
          expect { task.destroy }.to change { Assignment.count }.by(-1)
        end
      end

      context "volunteer for the assignment is deleted" do
        it "deletes associated assignments" do
          expect { volunteer.destroy }.to change { Assignment.count }.by(-1)
        end
      end
    end
  end
end
