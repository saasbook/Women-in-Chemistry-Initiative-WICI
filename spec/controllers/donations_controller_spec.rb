require 'rails_helper'

describe DonationsController do
  describe "#index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "validates a good donation amount" do
      get :new, params: { amount_dollars: 10 }
      expect(response).to render_template("new")
    end

    context "bad donation amount" do
      it "fails with an invalid amount of money" do
        get :new, params: { amount_dollars: 10.999 }
        expect(response).to redirect_to(donations_path)
        expect(flash[:alert]).to eq "Please enter a valid amount in USD to donate!"
      end
    end
  end

  describe "#create" do
    it "creates a charge given valid information" do
      card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
      post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token, amount_dollars: 10 }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq "Payment successfully processed! Check your email for a receipt."
    end

    context "invalid money entries" do
      it "fails with invalid amount of money" do
        card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
        post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token, amount_dollars: 10.999 }
        expect(response).to redirect_to(donations_path)
        expect(flash[:alert]).to eq "Please enter a valid amount in USD to donate!"
      end

      it "redirects to donations page on bad card" do
        StripeMock.prepare_card_error(:invalid_expiry_year)
        card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 1988)
        post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token, amount_dollars: 10 }
        expect(response).to redirect_to(donations_path)
        expect(flash[:alert]).to eq "The card's expiration year is invalid"
      end
    end
  end
end