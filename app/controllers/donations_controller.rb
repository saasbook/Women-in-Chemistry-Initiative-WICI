class DonationsController < ApplicationController
  def index
  end

  def new
    @donation = Donation.new(donation_params)
    unless @donation.valid?
      flash[:alert] = "Please enter a valid amount in USD to donate!"
      redirect_to donations_path
    end
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.valid?
      customer = Stripe::Customer.create({
                                             email: params[:stripeEmail],
                                             source: params[:stripeToken],
                                         })

      charge = Stripe::Charge.create({
                                         customer: customer.id,
                                         amount: @donation.amount_cents,
                                         description: 'Rails Stripe customer',
                                         currency: 'usd',
                                     })

      flash[:notice] = "Payment successfully processed! Check your email for a receipt."
      redirect_to donations_path
    else
      flash[:alert] = "Please enter a valid amount in USD to donate!"
      redirect_to donations_path
    end
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to donations_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.permit(:amount_dollars)
    end
end

