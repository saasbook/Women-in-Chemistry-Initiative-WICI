require "rails_helper"

describe RemindersMailer do
  let!(:event) { FactoryBot.create(:event) }
  let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }

  describe "remind" do
    it "renders the subject" do
      mail = described_class.remind_guest(guest, event)
      expect(mail.subject).to eq ("WICI Event Reminder")
    end

    it "sends to the right email" do
      mail = described_class.remind_guest(guest, event)
      expect(mail.to).to eq [guest.email]
    end

    it "renders the from email" do
      mail = described_class.remind_guest(guest, event)
      expect(mail.from).to eq ["wiciberkeley@gmail.com"]
    end
  end
end
