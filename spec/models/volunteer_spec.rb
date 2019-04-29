require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  let!(:volunteer) { FactoryBot.create(:volunteer)}
  let!(:unapproved_volunteer) { FactoryGirl.create(:unapproved_volunteer)}
  let!(:event) { FactoryBot.create(:event) }
  let!(:task) { FactoryBot.create(:task, event_id: event.id)}

  it "cannot destroy tasks" do
    expect(volunteer.can_destroy?(task)).to be false
  end

  it "can be approved" do
    unapproved_volunteer.approve
    expect(unapproved_volunteer.approved).to be true
  end

  it "has an inactive message" do
    expect(volunteer.inactive_message).to be :inactive
  end


end
