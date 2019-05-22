require 'rails_helper'

describe PhotosController do
  context "as a user" do
    before do
      FactoryBot.create(:photo)
    end

    describe "#home" do
      it "displays all photos nicely layed out" do
        get :home
        expect(assigns(:photos)).not_to be_nil
        expect(assigns(:photos).length).to eq 1
      end
    end
  end

  context "as an admin" do
    before do
      FactoryBot.create(:photo)
    end

    login_admin

    describe "#index" do
      it "gets a list of all photos" do
        get :index
        expect(assigns(:photos)).not_to be_nil
        expect(assigns(:photos).length).to eq 1
      end
    end

    describe "#new" do
      it "creates a new photo called @photo" do
        get :new
        expect(assigns(:photo)).not_to be_nil
        expect(assigns(:photo)).to be_a_new(Photo)
      end
    end

    describe "#create" do
      it "creates a photo" do
        expect { post :create, params: { photo: FactoryBot.attributes_for(:photo) }
      }.to change { Photo.count }.by(1)
      end
      context "invalid photo" do
        it "re-renders new template" do
          post :create, params: { photo: FactoryBot.attributes_for(:bad_photo) }
          expect(response).to render_template("new")
        end
        it "does not add a new photo" do
          expect { post :create, params: { photo: FactoryBot.attributes_for(:bad_photo) }
        }.to change { Photo.count }.by(0)
        end
      end
    end


    describe "#destroy" do
      let!(:photo) { FactoryBot.create(:photo) }
      it "deletes a photo" do
        expect { delete :destroy, params: { id: photo.id }
      }.to change { Photo.count }.by(-1)
      end

      it "redirects to index" do
        delete :destroy, params: { id: photo.id }
        expect(response).to redirect_to(photos_url)
      end
    end

    describe "#update" do
      let!(:photo) { FactoryBot.create(:photo) }

      it "updates an existing photo" do
        put :update, params: {id: photo.id, photo: FactoryBot.attributes_for(:photo, description: "modified")}
        photo.reload
        expect(photo.description).to eql("modified")
      end
      it "updates a photo with a good picture" do
        put :update, params: {id: photo.id, photo: FactoryBot.attributes_for(:photo, image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png'))))}
        photo.reload
        expect(photo.image).not_to be_nil
      end

      context "invalid attributes" do
        it "re-renders the edit template" do
          put :update, params: { id: photo.id, photo: FactoryBot.attributes_for(:bad_photo) }
          expect(response).to render_template("edit")
        end

        it "re-renders the edit template for to large file type" do
          put :update, params: { id: photo.id, photo: FactoryBot.attributes_for(:large_photo) }
          expect(response).to render_template("edit")
        end

        it "does not add a new photo" do
          expect { put :update, params: { id: photo.id, photo: FactoryBot.attributes_for(:bad_photo) }
        }.to change { Photo.count }.by(0)
        end
      end
    end
  end
end
