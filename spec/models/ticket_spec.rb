require "rails_helper"

describe Ticket do
  describe "#generate_code" do
    it "generates a code" do
      ticket = Ticket.new
      ticket.generate_code
      expect(ticket.code.length).to eql(64)
    end
  end

  describe "#approved?" do
    it "accepts a valid code" do
      event = FactoryBot.create(:event)
      guest = FactoryBot.create(:guest, event_id: event.id)
      ticket = FactoryBot.create(:ticket, guest_id: guest.id)
      guest.ticket = ticket

      expect(Ticket.approved?(ticket.code, guest)).to eq(true)
    end
    it "doesn't accept an invalid code" do
      event = FactoryBot.create(:event)
      guest = FactoryBot.create(:guest, event_id: event.id)
      ticket = FactoryBot.create(:ticket, guest_id: guest.id)
      guest.ticket = ticket

      expect(Ticket.approved?("no", guest)).to eq(false)
    end
  end
end