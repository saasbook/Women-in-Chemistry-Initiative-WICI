require 'rails_helper'

describe MessagesController do
  describe "#create" do
    it "creates message to contact admin" do
      post :create, params: {:message => { :name => 'Aaron Sumner',
        :email => 'aaron@everydayrails.com', :body => 'What a great website.'}}
      expect(flash[:notice]).to eql("Message received, thanks!")
      expect(response).to redirect_to(new_message_path)
    end
  end
end
