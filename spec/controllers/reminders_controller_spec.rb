require 'rails_helper'
include ActiveJob::TestHelper
describe RemindersController do
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  let!(:fut_event) { FactoryGirl.create(:future_event, id: 2) }
  let!(:test_guest) { FactoryGirl.create(:guest, event_id: test_event.id, email: "nicole_pb@ymail.com") }

  it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
          RemindersMailer.remind_guest(:test_guest, :test_event).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
  end

end
