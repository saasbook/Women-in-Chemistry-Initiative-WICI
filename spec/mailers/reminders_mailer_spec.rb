require "rails_helper"

describe RemindersMailer  do
  let!(:test_event) { FactoryGirl.create(:event, id: 1) }
  describe "remind guest" do
    context "headers" do
      let!(:test_guest) { FactoryGirl.create(:guest, event_id: test_event.id, firstname: "Andy", lastname: "P", email: "a@gmail.com") }
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
  describe "remind task" do
    context "headers" do
      let!(:test_volunteer) { FactoryGirl.create(:test_volunteer, id: 1)}
      let!(:test_task) { FactoryGirl.create(:task, event_id: 1, id: 1)}
      let!(:test_create_task) { FactoryGirl.create(:create_task, event_id: 1, id: 2)}
      let!(:test_assignment) { FactoryGirl.create(:assignment, task_id: 1, volunteer_id: 1)}
      it "renders the subject" do
        mail = described_class.remind_task(test_assignment.volunteer, test_task)
        expect(mail.subject).to eq ("WICI Task Volunteer Reminder")
      end
      it "sends to the right email" do
        mail = described_class.remind_task(test_assignment.volunteer, test_task)
        expect(mail.to).to eq [test_assignment.volunteer.email]
      end
      it "renders the from email" do
        mail = described_class.remind_task(test_assignment.volunteer, test_task)
        expect(mail.from).to eq ["wiciberkeley@gmail.com"]
      end
    end
  end
end
