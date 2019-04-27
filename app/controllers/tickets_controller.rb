class TicketsController < ApplicationController
  before_action :set_event

  def check
    if Ticket.approved?(ticket_params[:code], @guest)
      render 'approved'
    else
      render 'denied'
    end
  end

  private
    def ticket_params
      params.permit(:code)
    end

    def set_event
      @guest = Guest.find(params[:guest_id])
    end
end
