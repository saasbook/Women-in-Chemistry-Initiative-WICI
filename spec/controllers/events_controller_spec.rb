require 'rails_helper'

describe EventsController do
  describe "#new" do
    it "creates a new event called @event" do
      get :new
      expect(assigns(:event)).not_to be_nil
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "#create" do
    it "creates an event" do
      expect { post :create, params: { event: FactoryBot.attributes_for(:event) }
      }.to change { Event.count }.by(1)
    end
    context "invalid attributes" do
      it "re-renders new template" do
        post :create, params: { event: FactoryBot.attributes_for(:invalid_event) }
        expect(response).to render_template("new")
      end
      it "does not add a new event" do
        expect { post :create, params: { event: FactoryBot.attributes_for(:invalid_event) }
        }.to change { Event.count }.by(0)
      end
    end
  end

  context "event lists" do
    before do
      FactoryBot.create(:event)
      FactoryBot.create(:past_event)
    end

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
  end

  context "specific event paths" do
    let!(:event) { FactoryBot.create(:event) }

    describe "#show" do
      before { FactoryBot.create(:guest, event_id: event.id) }

      it "shows an event and it's associated guests" do
        get :show, params: { id: event.id }
        expect(assigns(:guests)).not_to be_nil
        expect(assigns(:guests).length).to eq 1
      end
    end

    describe "#destroy" do
      it "deletes an event" do
        expect { delete :destroy, params: { id: event.id }
        }.to change { Event.count }.by(-1)
      end

      it "redirects to index" do
        delete :destroy, params: { id: event.id }
        expect(response).to redirect_to(events_path)
      end
    end

    describe "#update" do
      it "updates an existing movie" do
        put :update, params: {id: event.id, event: FactoryBot.attributes_for(:event, name: "modified")}
        event.reload
        expect(event.name).to eql("modified")
      end

      context "invalid attributes" do
        it "re-renders the edit template" do
          put :update, params: { id: event.id, event: FactoryBot.attributes_for(:invalid_event) }
          expect(response).to render_template("edit")
        end

        it "does not add a new event" do
          expect { put :update, params: { id: event.id, event: FactoryBot.attributes_for(:invalid_event) }
          }.to change { Event.count }.by(0)
        end
      end
    end
  end
end