require 'rails_helper'

describe EventsController do
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:fut_event) { FactoryGirl.create(:future_event, id: 2) }
  let!(:test_guest) { FactoryGirl.create(:guest, event_id: test_event.id) }

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

  describe "show" do
    it "shows an event and it's associated guests" do
      get :show, params: { id: test_event.id }
      expect(assigns(:guests)).not_to be_nil
      expect(assigns(:guests).length).to eq 1
    end
  end


  describe "#destroy" do
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

    it "updates an event with a good picture" do
      put :update, params: {id: test_event.id, event: FactoryGirl.attributes_for(:event, image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png'))))}
      test_event.reload
      expect(test_event.image).not_to be_nil
    end

    context "invalid attributes" do
      it "re-renders the edit template" do
        put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:invalid_event) }
        expect(response).to render_template("edit")
      end

      it "re-renders the edit template for bad file type" do
        put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:bad_photo_event) }
        expect(response).to render_template("edit")
      end

      it "re-renders the edit template for to large file type" do
        put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:large_photo_event) }
        expect(response).to render_template("edit")
      end

      it "does not add a new event" do
        expect { put :update, params: { id: test_event.id, event: FactoryGirl.attributes_for(:invalid_event) }
        }.to change { Event.count }.by(0)
      end
    end
  end
end