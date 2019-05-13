require 'rails_helper'

describe MessagesController do
  describe "#new" do
    it "creates a new message object" do
      get :new
      expect(assigns(:message)).not_to be_nil
    end
  end

  describe "#create" do
    it "creates message to contact admin" do
      post :create, params: {:message => { :name => 'Aaron Sumner',
        :email => 'aaron@everydayrails.com', :body => 'What a great website.'}}
      expect(flash[:notice]).to eql("Message has been sent.")
      expect(response).to redirect_to(new_message_path)
    end

    it "does not send if params are invalid" do
      post :create, params: {:message => { :name => 'Aaron Sumner',
                                           :email => 'aaroneverydayrails.com', :body => 'What a great website.'}}
      expect(response).to render_template("new")
      expect(flash[:alert]).to eql("Please correct the errors below.")
    end
  end
end
