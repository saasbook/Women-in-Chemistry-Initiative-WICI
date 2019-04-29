require 'rails_helper'

describe EventsController do
  context "as a user" do
    before do
      FactoryBot.create(:past_event)
      FactoryBot.create(:event)
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

    describe "show" do
      it "shows an event and it's associated guests" do
        event = FactoryBot.create(:event)
        FactoryBot.create(:guest, event_id: event.id)
        get :show, params: { id: event.id }
        expect(assigns(:guests)).not_to be_nil
        expect(assigns(:guests).length).to eq 1
      end
    end
  end

  context "as an admin" do
    before do
      FactoryBot.create(:past_event)
    end

    login_admin

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


    describe "#destroy" do
      let!(:event) { FactoryBot.create(:event) }
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
      let!(:event) { FactoryBot.create(:event) }

      it "updates an existing movie" do
        put :update, params: {id: event.id, event: FactoryBot.attributes_for(:event, name: "modified")}
        event.reload
        expect(event.name).to eql("modified")
      end
      it "updates an event with a good picture" do
        put :update, params: {id: event.id, event: FactoryGirl.attributes_for(:event, image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png'))))}
        event.reload
        expect(event.image).not_to be_nil
      end

      context "invalid attributes" do
        it "re-renders the edit template" do
          put :update, params: { id: event.id, event: FactoryBot.attributes_for(:invalid_event) }
          expect(response).to render_template("edit")
        end

        it "re-renders the edit template for bad file type" do
          put :update, params: { id: event.id, event: FactoryGirl.attributes_for(:bad_photo_event) }
          expect(response).to render_template("edit")
        end

        it "re-renders the edit template for to large file type" do
          put :update, params: { id: event.id, event: FactoryGirl.attributes_for(:large_photo_event) }
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
