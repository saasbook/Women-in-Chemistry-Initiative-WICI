require 'rails_helper'

describe Event do
  describe "#amount_cents" do
    it "converts dollars to cents" do
      event = FactoryBot.create(:event)
      expect(event.amount_cents).to eq (1025)
    end
  end

  describe "#past_event?" do
    it "returns false if event is in the future" do
      event = FactoryBot.create(:event)
      expect(event.past_event?).to eq (false)
    end

    it "returns true if event is in the past" do
      past_event = FactoryBot.create(:past_event)
      expect(past_event.past_event?).to eq (true)
    end
  end
end