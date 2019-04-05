require 'rails_helper'

describe EventsController do
  let!(:test_event) { FactoryGirl.create(:event) }
  let!(:test_event_two) { FactoryGirl.create(:future_event) }


  describe "#index" do
    it "gets a list of all future events" do
      get :index
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:events).length).to eq 1
    end
  end

  describe "#past_events" do
    it "gets a list of all past events" do
      get :past_events
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:events).length).to eq 1
    end
  end

  describe "#new" do
    it "creates a new event called @event" do
      get :new
      expect(assigns(:event)).not_to be_nil
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "#create" do
    it "creates an event" do
      expect { post :create, params: { event: FactoryGirl.attributes_for(:event) }
      }.to change { Event.count }.by(1)
    end
    context "invalid attributes" do
      it "re-renders new template" do
        post :create, params: { event: FactoryGirl.attributes_for(:invalid_event) }
        expect(response).to render_template("new")
      end
      it "does not add a new event" do
        expect { post :create, params: { event: FactoryGirl.attributes_for(:invalid_event) }
        }.to change { Event.count }.by(0)
      end
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

    context "invalid attributes" do
      it "re-renders the edit template" do
        put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:invalid_event) }
        expect(response).to render_template("edit")
      end

      it "does not add a new event" do
        expect { put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:invalid_event) }
        }.to change { Event.count }.by(0)
      end
    end
  end
end