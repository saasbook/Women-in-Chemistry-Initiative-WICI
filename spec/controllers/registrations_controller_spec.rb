describe Admins::RegistrationsController do
  let!(:admin) { FactoryBot.create(:other_admin)}
  let!(:unapproved_admin) { FactoryBot.create(:unapproved_admin)}

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

  describe "#toggle_donation_show" do
    it "toggles the @@show class variable" do
      curr = Donation.show
      post :toggle_donation_show
      expect(Donation.show).to eql(!curr)
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
      expect { delete :destroy, params: { id: admin.id }
      }.to change { Admin.count }.by(-1)
    end

    it "cannot delete current admin" do
      expect { delete :destroy, params: { id: FactoryBot.attributes_for(:admin)[:id] }
      }.to change { Admin.count }.by(0)
    end

    it "redirects to index" do
      delete :destroy, params: { id: admin.id }
      expect(response).to redirect_to(accounts_path)
    end
  end

end

describe Volunteers::RegistrationsController do
  let!(:volunteer) { FactoryBot.create(:volunteer)}
  let!(:unapproved_volunteer) { FactoryBot.create(:unapproved_volunteer)}

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
      expect { delete :destroy, params: { id: volunteer.id }
      }.to change { Volunteer.count }.by(-1)
    end

    it "redirects to index" do
      delete :destroy, params: { id: volunteer.id }
      expect(response).to redirect_to(accounts_path)
    end
  end

end
