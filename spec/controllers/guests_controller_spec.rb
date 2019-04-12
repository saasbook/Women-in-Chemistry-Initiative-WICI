describe GuestsController do
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:test_guest) { FactoryGirl.create(:guest, event_id: test_event.id)}
  let!(:full_event) { FactoryGirl.create(:full_event, id: 2)}


  describe "#new" do
    it "creates a new guest called @guest" do
      get :new, params: { event_id: test_event.id }
      expect(assigns(:guest)).not_to be_nil
      expect(assigns(:guest)).to be_a_new(Guest)
    end
  end

  describe "#create" do
    it "adds a guest" do
      expect { post :create, params: { guest: FactoryGirl.attributes_for(:guest), event_id: test_event.id }
      }.to change { Guest.count }.by(1)
    end
    context "invalid attributes" do
      it "re-renders new template" do
        post :create, params: { guest: FactoryGirl.attributes_for(:invalid_guest), event_id: test_event.id }
        expect(response).to render_template("new")
      end
      it "does not add a new guest" do
        expect { post :create, params: { guest: FactoryGirl.attributes_for(:invalid_guest), event_id: test_event.id }
        }.to change { Guest.count }.by(0)
      end
    end
    context "full event" do
      it "re-renders new template" do
        post :create, params: { guest: FactoryGirl.attributes_for(:guest), event_id: full_event.id }
        expect(response).to render_template("new")
      end
      it "does not add a new guest" do
        expect { post :create, params: { guest: FactoryGirl.attributes_for(:guest), event_id: full_event.id }
        }.to change { Guest.count }.by(0)
      end
    end
  end

  describe "#destroy" do
    it "deletes an guest" do
      expect { delete :destroy, params: { id: test_guest.id, event_id: test_event.id }
      }.to change { Guest.count }.by(-1)
    end

    it "redirects to index" do
      delete :destroy, params: { id: test_guest.id, event_id: test_event.id }
      expect(response).to redirect_to(events_path)
    end

    context "event guest is attending is deleted" do
      it "deletes associated guests" do
        expect { test_guest.destroy }.to change { Guest.count }.by(-1)
      end
    end
  end
end