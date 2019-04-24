require "rails_helper"

describe Guest do
  describe "#generate_qr_code" do
    it "generates a qr code" do
      guest = FactoryBot.build(:guest)
      ticket = FactoryBot.build(:ticket, guest_id: guest.id)
      guest.ticket = ticket
      expect(guest.generate_qr_code("www.website.com")).to be_instance_of(ChunkyPNG::Image)
    end
  end
end