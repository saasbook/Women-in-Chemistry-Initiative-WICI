class AssignmentsController < ApplicationController
  before_action :set_event_and_task, only: [:index, :create, :new, :destroy]
  before_action do
    if !current_admin.nil?
      authenticate_admin!
      @user = current_admin
    else
      authenticate_volunteer!
      @user = current_volunteer
    end
  end


  def index
    @assignments = @event.assignments
    @info = @assignments.empty? ? "#{@event.name} has no volunteers #{@task.id}." : ''
  end
  # GET /events/new
  def new
    @assignment = Assignment.new
  end

  # POST /events
  # POST /events.json
  def create

    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to event_assignments_path(@event), notice: 'You are now a volunteer.' }
        format.json { render :show, status: :created, location: @assignment.event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Volunteer was successfully unassigned.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_event_and_task
      @event = Event.find(params[:event_id])
      @task = Task.get_none_task(@event)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:task_id, :volunteer_id)
    end
end
