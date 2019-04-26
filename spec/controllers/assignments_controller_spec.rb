require 'rails_helper'

describe AssignmentsController do
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:test_volunteer) { FactoryGirl.create(:test_volunteer, id: 1)}
  let!(:test_task) { FactoryGirl.create(:task, event_id: 1, id: 1)}
  let!(:test_create_task) { FactoryGirl.create(:create_task, event_id: 1, id: 2)}
  let!(:test_assignment) { FactoryGirl.create(:assignment, task_id: 1, volunteer_id: 1)}

  context "as a volunteer" do

    before :each do
      setup_controller_for_warden
      request.env['devise.mapping'] = Devise.mappings[:volunteer]
    end

    login_volunteer

    describe "#new" do
      it "creates a new assignment called @assignment" do
        get :new, params: { event_id: test_event.id, task_id: test_task.id }
        expect(assigns(:assignment)).not_to be_nil
        expect(assigns(:assignment)).to be_a_new(Assignment)
      end
      it "does not allow duplicate assignments" do
        post :create, params: { assignment: FactoryGirl.attributes_for(:dupe_assignment), event_id: test_event.id, task_id: test_task.id }
        get :new, params: { event_id: test_event.id, task_id: test_task.id}
        expect(assigns(:assignment)).not_to be_nil
        expect(assigns(:assignment)).not_to be_a_new(Assignment)
      end
    end

    describe "#create" do
      it "adds an assignment" do
        expect { post :create, params: { assignment: FactoryGirl.attributes_for(:create_assignment), event_id: test_event.id, task_id: test_task.id }
        }.to change { Assignment.count }.by(1)
      end
      it "adds a existing assignment" do
        expect { post :create, params: { assignment: FactoryGirl.attributes_for(:assignment), event_id: test_event.id, task_id: test_task.id }
        }.to change { Assignment.count }.by(0)
      end
      it 'creates reminder job' do
          ActiveJob::Base.queue_adapter = :test
          expect { RemindersMailer.remind_task(test_assignment.volunteer, test_task).deliver_later
          }.to have_enqueued_job.on_queue('mailers')
      end
    end

    describe "#destroy" do
      it "can delete their own assignment" do
        another = FactoryGirl.create(:create_assignment)
        expect { delete :destroy, params: { id: another.id, event_id: test_event.id, task_id: test_task.id}
        }.to change { Assignment.count }.by(-1)
      end

      it "cannot delete another assignment" do
        expect { delete :destroy, params: { id: test_assignment.id, event_id: test_event.id, task_id: test_task.id}
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
      it "deletes an assignment" do
        expect { delete :destroy, params: { id: test_assignment.id, event_id: test_event.id, task_id: test_task.id}
        }.to change { Assignment.count }.by(-1)
      end

      context "task for the assignment is deleted" do
        it "deletes associated assignments" do
          expect { test_task.destroy }.to change { Assignment.count }.by(-1)
        end
      end

      context "volunteer for the assignment is deleted" do
        it "deletes associated assignments" do
          expect { test_volunteer.destroy }.to change { Assignment.count }.by(-1)
        end
      end
    end
  end
end
