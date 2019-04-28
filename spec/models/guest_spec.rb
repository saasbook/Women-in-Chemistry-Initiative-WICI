require "rails_helper"

describe Guest do
  describe "#generate_qr_code" do
    it "generates a qr code" do
      expect(Guest.generate_qr_code("www.website.com")).to be_instance_of(ChunkyPNG::Image)
    end
  end
end