require "rails_helper"
describe GuestsController do
  let!(:event) { FactoryBot.create(:event) }

  describe "#new" do
    it "creates a new guest called @guest" do
      get :new, params: { event_id: event.id }
      expect(assigns(:guest)).not_to be_nil
      expect(assigns(:guest)).to be_a_new(Guest)
    end
  end

  describe "#create" do
    it "adds a guest" do
      expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: event.id }
      }.to change { Guest.count }.by(1)
    end
    it "creates a mailer job" do
      guest = FactoryBot.build_stubbed(:guest)

      ActiveJob::Base.queue_adapter = :test
      expect {
          RemindersMailer.remind_guest(guest, event).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end
    context "invalid attributes" do
      it "re-renders new template" do
        post :create, params: { guest: FactoryBot.attributes_for(:invalid_guest), event_id: event.id }
        expect(response).to render_template("new")
      end
      it "does not add a new guest" do
        expect { post :create, params: { guest: FactoryBot.attributes_for(:invalid_guest), event_id: event.id }
        }.to change { Guest.count }.by(0)
      end
    end
    context "when the event is a full event" do
      let!(:full_event) { FactoryBot.create(:full_event) }

      it "re-renders new template" do
        post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: full_event.id }
        expect(response).to render_template("new")
      end
      it "does not add a new guest" do
        expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: full_event.id }
        }.to change { Guest.count }.by(0)
      end
    end
  end

  describe "#destroy" do
    let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }

    it "deletes an guest" do
      expect { delete :destroy, params: { id: guest.id, event_id: event.id }
      }.to change { Guest.count }.by(-1)
    end

    it "redirects to index" do
      delete :destroy, params: { id: guest.id, event_id: event.id }
      expect(response).to redirect_to(events_path)
    end

    context "when an event guest is attending is deleted" do
      it "deletes associated guests" do
        expect { event.destroy }.to change { Guest.count }.by(-1)
      end
    end
  end
end
