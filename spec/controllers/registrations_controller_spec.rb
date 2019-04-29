describe Admins::RegistrationsController do
  let!(:test_admin) { FactoryGirl.create(:test_admin, id: 1)}
  let!(:unapproved_admin) { FactoryGirl.create(:unapproved_admin)}

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:admin]
  end

  login_admin

  describe "#index" do
    it "can view a list of admins and volunteers" do
      get :index
      expect(assigns(:admins)).not_to be_nil
      expect(assigns(:volunteers)).not_to be_nil
    end
  end

  describe "approve" do
    it "approves an admin" do
      post :approve, params: {id: unapproved_admin.id}
      expect(unapproved_admin.approved).to be true
    end

    it "redirects to index" do
      post :approve, params: {id: unapproved_admin.id}
      expect(response).to redirect_to(accounts_path)
    end
  end

  describe "#destroy" do
    it "deletes an admin" do
      expect { delete :destroy, params: { id: test_admin.id }
      }.to change { Admin.count }.by(-1)
    end

    it "cannot delete current admin" do
      expect { delete :destroy, params: { id: 2}
      }.to change { Admin.count }.by(0)
    end

    it "redirects to index" do
      delete :destroy, params: { id: test_admin.id }
      expect(response).to redirect_to(accounts_path)
    end
  end

end

describe Volunteers::RegistrationsController do
  let!(:test_volunteer) { FactoryGirl.create(:test_volunteer, id: 1)}
  let!(:unapproved_volunteer) { FactoryGirl.create(:unapproved_volunteer)}

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:admin]
  end

  login_admin

  describe "approve" do
    it "approves a volunteer" do
      post :approve, params: {id: unapproved_volunteer.id}
      expect(unapproved_volunteer.approved).to be true
    end

    it "redirects to index" do
      post :approve, params: {id: unapproved_volunteer.id}
      expect(response).to redirect_to(accounts_path)
    end
  end

  describe "#destroy" do
    it "deletes a volunteer" do
      expect { delete :destroy, params: { id: test_volunteer.id }
      }.to change { Volunteer.count }.by(-1)
    end

    it "redirects to index" do
      delete :destroy, params: { id: test_volunteer.id }
      expect(response).to redirect_to(accounts_path)
    end
  end

end
