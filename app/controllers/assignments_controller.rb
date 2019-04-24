class AssignmentsController < ApplicationController
  before_action :set_event_and_task
  before_action :set_assignment, only: [:destroy]
  before_action :authenticate
  before_action :check_assignment

  # event_assignments
  def index
    @assignments = @event.assignments
    @info = @assignments.empty? ? "#{@event.name} has no volunteers." : ''
    render "assignments/_index"
  end
  # new_event_assignment
  def new
    if @assignment_exists
      respond_to do |format|
        format.html { redirect_to event_task_path(@event, @task), notice: 'You are already a volunteer.' }
        format.json { render :index, status: :conflict, location: @assignment.event }
      end
    else
      @assignment = Assignment.new
    end
  end

  # POST /events
  # POST /events.json
  def create

    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to event_task_path(@event, @task), notice: 'You are now a volunteer.' }
        if @task.deadline.nil?
          @task.deadline = @event.date
        end
        RemindersMailer.remind_task(@assignment.volunteer, @task).deliver_later(wait_until: @task.deadline - 1)
        format.json { render :show, status: :created, location: @assignment.event }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if current_admin || @assignment.volunteer == @user
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to event_task_path(@event, @task), notice: 'Volunteer was successfully unassigned.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to event_task_path(@event, @task)}
        format.json { render :index, status: :unauthorized, location: @assignment.event }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_event_and_task
      @event = Event.find(params[:event_id])
      @task = Task.find_by_id(params[:task_id])
    end

    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def check_assignment
      @assignment_exists = Assignment.exists?(task_id: @task.id, volunteer_id: @user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:task_id, :volunteer_id)
    end

    def authenticate
      if admin_signed_in?
        authenticate_admin!
        @user = current_admin
      else
        authenticate_volunteer!
        @user = current_volunteer
      end
    end
end
