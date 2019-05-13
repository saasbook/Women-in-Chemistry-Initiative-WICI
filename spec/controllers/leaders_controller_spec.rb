require 'rails_helper'

describe LeadersController do

  context "as an admin" do


    login_admin

    describe "#new" do
      it "creates a new leader called @leader" do
        get :new
        expect(assigns(:leader)).not_to be_nil
        expect(assigns(:leader)).to be_a_new(Leader)
      end
    end

    describe "#create" do
      it "creates a leader" do
        expect { post :create, params: { leader: FactoryBot.attributes_for(:leader) }
        }.to change { Leader.count }.by(1)
      end
      context "invalid attributes" do
        it "re-renders new template" do
          post :create, params: { leader: FactoryBot.attributes_for(:invalid_leader) }
          expect(response).to render_template("new")
        end
        it "does not add a new leader" do
          expect { post :create, params: { leader: FactoryBot.attributes_for(:invalid_leader) }
          }.to change { Leader.count }.by(0)
        end
      end
    end


    describe "#destroy" do
      let!(:leader) { FactoryBot.create(:leader) }
      it "deletes a leader" do
        expect { delete :destroy, params: { id: leader.id }
        }.to change { Leader.count }.by(-1)
      end

      it "redirects to about" do
        delete :destroy, params: { id: leader.id }
        expect(response).to redirect_to(about_index_path)
      end
    end

    describe "#update" do
      let!(:leader) { FactoryBot.create(:leader) }

      it "updates an existing leader" do
        put :update, params: {id: leader.id, leader: FactoryBot.attributes_for(:leader, firstname: "modified")}
        leader.reload
        expect(leader.firstname).to eql("modified")
      end
      it "updates a leader with a good picture" do
        put :update, params: {id: leader.id, leader: FactoryBot.attributes_for(:leader, image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png'))))}
        leader.reload
        expect(leader.image).not_to be_nil
      end

      context "invalid attributes" do
        it "re-renders the edit template" do
          put :update, params: { id: leader.id, leader: FactoryBot.attributes_for(:invalid_leader) }
          expect(response).to render_template("edit")
        end

        it "re-renders the edit template for bad file type" do
          put :update, params: { id: leader.id, leader: FactoryBot.attributes_for(:bad_photo_leader) }
          expect(response).to render_template("edit")
        end

        it "re-renders the edit template for to large file type" do
          put :update, params: { id: leader.id, leader: FactoryBot.attributes_for(:large_photo_leader) }
          expect(response).to render_template("edit")
        end

        it "does not add a new leader" do
          expect { put :update, params: { id: leader.id, leader: FactoryBot.attributes_for(:invalid_leader) }
          }.to change { Leader.count }.by(0)
        end
      end
    end
  end
end
