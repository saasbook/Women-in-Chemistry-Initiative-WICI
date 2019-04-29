require "rails_helper"

describe Ticket do
  let!(:event) { FactoryBot.create(:event) }
  let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }
  let!(:ticket) { FactoryBot.create(:ticket, guest_id: guest.id) }

  describe "#generate_code" do
    it "generates a code" do
      ticket.generate_code
      expect(ticket.code.length).to eql(64)
    end
  end

  describe "#approved?" do
    it "accepts a valid code" do
      expect(Ticket.approved?(ticket.code, guest)).to eq(true)
    end
    it "doesn't accept an invalid code" do
      expect(Ticket.approved?("no", guest)).to eq(false)
    end
  end
end