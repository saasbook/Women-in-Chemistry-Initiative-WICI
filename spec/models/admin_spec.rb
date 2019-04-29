require 'rails_helper'

RSpec.describe Admin, :type => :model do
  let!(:test_admin) { FactoryGirl.create(:test_admin, id: 1)}
  let!(:unapproved_admin) { FactoryGirl.create(:unapproved_admin)}
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:test_task) { FactoryGirl.create(:task, event_id: 1, id: 1)}

  it "can destroy tasks" do
    expect(test_admin.can_destroy?(test_task)).to be true
  end

  it "can be approved" do
    unapproved_admin.approve
    expect(unapproved_admin.approved).to be true
  end

  it "has an inactive message" do
    expect(test_admin.inactive_message).to be :inactive
  end

end
