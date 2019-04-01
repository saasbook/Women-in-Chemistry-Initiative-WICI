class GuestsController < ApplicationController
	def new
		@guest = Guest.new
		@guests = Guest.all
	end
	def create
		params.permit!
		@guest = Guest.new(params[:guest])
		if @guest.save
			redirect_to new_guest_path
		end
	end

	def show
		@guests = Guest.all
		render "guests/show"
	end

end
