require "rails_helper"

describe Ticket do
  describe "#generate_code" do
    it "generates a code" do
      ticket = Ticket.new
      ticket.generate_code
      expect(ticket.code.length).to eql(64)
    end
  end
end