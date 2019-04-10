class GuestsController < ApplicationController
	def new
		@guest = Guest.new
		@guests = Guest.all
		@all_events = Event.all
	end
	def create
		params.permit!
		@guest = Guest.new(params[:guest])
		if @guest.firstname.blank?
			flash[:notice] = "Must enter your first name!"
		elsif @guest.lastname.blank?
			flash[:notice] = "Must enter your last name!"
		elsif @guest.email.blank?
			flash[:notice] = "Must enter your email!"
		elsif @guest.event.blank?
			flash[:notice] = "Must select an event!"
		elsif @guest.save
			flash[:notice] = "You're on the list!"
		end
		redirect_to new_guest_path
	end

	def show
		@guests = Guest.all
		render "guests/show"
	end

end
