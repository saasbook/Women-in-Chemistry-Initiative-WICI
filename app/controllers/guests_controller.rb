class GuestsController < ApplicationController
  before_action :set_guest, only: [:destroy]
  before_action :set_event
  before_action :authenticate_admin!, only: [:destroy]


  def new
    @guest = Guest.new
  end

  def create
    @guest = @event.guests.new(guest_params)
    @guest.ticket = Ticket.new

    if @event.save
      stripe_charge if @event.has_tickets
      confirm_and_remind
      
      flash[:notice] = 'You have successfully registered! Check your email for confirmation.'
      redirect_to event_path(@event)
    else
      flash[:alert] = 'Your registration failed, please make sure your information is correct.'
      render "new"
    end
  rescue Stripe::CardError => e
    @guest.destroy
    flash[:alert] = e.message
    render "new"
  end

  def destroy
    event = @guest.event
    @guest.destroy
    respond_to do |format|
      format.html { redirect_to event_url(event), notice: 'Guest was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def stripe_charge
      customer = Stripe::Customer.create({
                                             email: params[:stripeEmail],
                                             source: params[:stripeToken],
                                         })

      charge = Stripe::Charge.create({
                                         customer: customer.id,
                                         amount: @event.amount_cents,
                                         description: 'Rails Stripe customer',
                                         currency: 'usd',
                                     })
    end

    def confirm_and_remind
      RemindersMailer.confirm_guest(@guest, @event, generate_qr_code).deliver
      RemindersMailer.remind_guest(@guest, @event).deliver_later(wait_until: @event.date - 1)
    end

    def generate_qr_code
      Guest.generate_qr_code(event_guest_check_ticket_url(@event, @guest, code: @guest.generate_code))
    end

    def guest_params
      @event.has_tickets ? guest_params_ticket : guest_params_no_ticket
    end

    def guest_params_ticket
      params.permit(:firstname, :lastname, :email, :occupation, :gender, :department)
    end

    def guest_params_no_ticket
      params.require(:guest).permit(:firstname, :lastname, :email, :occupation, :gender, :department)
    end

    def set_guest
      @guest = Guest.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end

