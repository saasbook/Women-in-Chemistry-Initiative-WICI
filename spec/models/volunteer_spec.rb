require 'rails_helper'

RSpec.describe Volunteer, :type => :model do
  let!(:test_volunteer) { FactoryGirl.create(:test_volunteer, id: 1)}
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:test_task) { FactoryGirl.create(:task, event_id: 1, id: 1)}
  it "cannot destroy tasks" do
    expect(test_volunteer.can_destroy?(test_task)).to be false
  end
end
