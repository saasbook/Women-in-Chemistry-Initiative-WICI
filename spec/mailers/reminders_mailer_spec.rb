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
      expect(mail.to[0]).to eq (guest.email)
    end

    it "renders the from email" do
      mail = described_class.remind_guest(guest, event)
      expect(mail.from[0]).to eq ("wiciberkeley@gmail.com")
    end
  end

  describe "confirm" do
    it "renders the subject" do
      mail = described_class.confirm_guest(guest, event, "")
      expect(mail.subject).to eq ("WICI Event Confirmation")
    end

    it "has an attachment" do
      qr_code = Guest.generate_qr_code("www.test.com")
      mail = described_class.confirm_guest(guest, event, qr_code)
      expect(mail.attachments).not_to be_nil
    end

    it "sends to the right email" do
      mail = described_class.confirm_guest(guest, event, "")
      expect(mail.to[0]).to eq(guest.email)
    end

    it "renders the from email" do
      mail = described_class.confirm_guest(guest, event, "")
      expect(mail.from[0]).to eq("wiciberkeley@gmail.com")
    end
  end
  describe "remind task" do
    context "headers" do
      let!(:volunteer) { FactoryBot.create(:volunteer, id: 1)}
      let!(:task) { FactoryBot.create(:task, event_id: 1, id: 1)}
      let!(:assignment) { FactoryBot.create(:assignment, task_id: 1, volunteer_id: 1)}
      it "renders the subject" do
        mail = described_class.remind_task(assignment.volunteer, task)
        expect(mail.subject).to eq ("WICI Task Volunteer Reminder")
      end
      it "sends to the right email" do
        mail = described_class.remind_task(assignment.volunteer, task)
        expect(mail.to[0]).to eq(assignment.volunteer.email)
      end
      it "renders the from email" do
        mail = described_class.remind_task(assignment.volunteer, task)
        expect(mail.from[0]).to eq("wiciberkeley@gmail.com")
      end
    end
  end
end
