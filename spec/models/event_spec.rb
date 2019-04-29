require 'rails_helper'

describe Event do
  describe "#amount_cents" do
    it "converts dollars to cents" do
      event = FactoryBot.create(:event)
      expect(event.amount_cents).to eq (1025)
    end
  end
end