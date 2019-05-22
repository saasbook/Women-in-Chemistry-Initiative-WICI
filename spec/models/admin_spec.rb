require 'rails_helper'

RSpec.describe Admin, :type => :model do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:unapproved_admin) { FactoryBot.create(:unapproved_admin) }
  let!(:event) { FactoryBot.create(:event) }
  let!(:task) { FactoryBot.create(:task, event_id: event.id) }

  it "can destroy tasks" do
    expect(admin.can_destroy?(task)).to be true
  end

  it "can be approved" do
    unapproved_admin.approve
    expect(unapproved_admin.approved).to be true
  end

  it "has an inactive message" do
    expect(admin.inactive_message).to be :inactive
  end

end
