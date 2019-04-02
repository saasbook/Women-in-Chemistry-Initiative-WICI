class VolunteersController < ApplicationController
  before_action :set_event, only: [:index, :create, :new, :destroy]

  def index
    @volunteers = @event.volunteers
    @info = @volunteers.empty? ? "#{@event.name} has no volunteers" : ''
  end
  # GET /events/new
  def new
    @volunteer = Volunteer.new
  end

  # POST /events
  # POST /events.json
  def create

    @volunteer = Volunteer.new(volunteer_params)

    respond_to do |format|
      if @volunteer.save
        format.html { redirect_to event_volunteers_path(@event), notice: 'You are now a volunteer.' }
        format.json { render :show, status: :created, location: @volunteer.event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Volunteer was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:name, :email, :event_id)
    end
end
