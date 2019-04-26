require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  let!(:volunteer) { FactoryBot.create(:volunteer)}
  let!(:event) { FactoryBot.create(:event) }
  let!(:task) { FactoryBot.create(:task, event_id: event.id)}
  it "cannot destroy tasks" do
    expect(volunteer.can_destroy?(task)).to be false
  end
end
