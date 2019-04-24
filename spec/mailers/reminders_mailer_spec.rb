require "rails_helper"

describe RemindersMailer  do
  let!(:test_event) { FactoryBot.create(:event, id: 10, name: "Event Test", description: "Great", date: "2019-04-14 20:22:21",
     location: "Here", tickets: 10, capacity: 10) }
  let!(:test_guest) { FactoryBot.create(:guest, event_id: test_event.id, firstname: "Andy", lastname: "P", email: "a@gmail.com") }
  describe "remind" do
    context "headers" do
      it "renders the subject" do
        mail = described_class.remind_guest(test_guest, test_event)
        expect(mail.subject).to eq ("WICI Event Reminder")
      end
      it "sends to the right email" do
        mail = described_class.remind_guest(test_guest, test_event)
        expect(mail.to).to eq [test_guest.email]
      end
      it "renders the from email" do
        mail = described_class.remind_guest(test_guest, test_event)
        expect(mail.from).to eq ["wiciberkeley@gmail.com"]
      end
    end
  end
end
