require 'rails_helper'

describe EventsController do
  let!(:test_event) { FactoryGirl.create(:event) }

  describe "#create" do
    it "creates an event" do
      expect { post :create, params: { event: FactoryGirl.attributes_for(:event) }
      }.to change { Event.count }.by(1)
    end
  end
  describe "#delete" do
    it "deletes an event" do
      expect { delete :destroy, params: { id: test_event.id }
      }.to change { Event.count }.by(-1)
    end

    it "redirects to index" do
      delete :destroy, params: { id: test_event.id }
      expect(response).to redirect_to(events_path)
    end
  end
  describe "#update" do
    it "updates an existing movie" do
      put :update, params: {id: test_event.id, event: FactoryGirl.attributes_for(:event, name: "modified")}
      test_event.reload
      expect(test_event.name).to eql("modified")
    end
  end
end