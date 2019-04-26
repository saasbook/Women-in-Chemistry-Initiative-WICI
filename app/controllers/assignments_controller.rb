class AssignmentsController < ApplicationController
  before_action :set_event_and_task
  before_action :set_assignment, only: [:destroy]
  before_action :set_user
  before_action :authenticate_volunteer!, only: [:create, :new]
  before_action :authenticate_all, except: [:create, :new]

  # new_event_assignment
  def new
    if @user.can_signup?(@task)
      @assignment = Assignment.new
    else
      redirect_to event_task_path(@event, @task)
    end
  end

  # POST /events
  # POST /events.json
  def create
    @assignment = Assignment.new(assignment_params)
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to event_task_path(@event, @task), notice: 'You are now a volunteer.' }
        @task.deadline = @event.date if @task.deadline.nil?
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
    if @user.can_destroy?(@assignment)
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to event_task_path(@event, @task), notice: 'Volunteer was successfully unassigned.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to event_task_path(@event, @task)}
        format.json { render :show, status: :unauthorized, location: @assignment }
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

    def set_user
      @user = admin_signed_in? ? current_admin : current_volunteer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:task_id, :volunteer_id)
    end

    def authenticate_all
      admin_signed_in? ? authenticate_admin! : authenticate_volunteer!
    end
end
