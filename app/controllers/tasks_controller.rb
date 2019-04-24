class TasksController < ApplicationController
  before_action :set_task, only: [:destroy, :update, :show, :edit]
  before_action :set_event
  before_action :set_assignments, only: [:destroy, :update, :show, :edit]

  def new
    @task = Task.new
  end

  def index
    @tasks = @event.tasks
  end

  def create
    @task = @event.tasks.new(task_params)

    if @event.save
      flash[:notice] = 'You have successfully added a new task!'
      redirect_to event_tasks_url(@event)
    else
      flash[:alert] = 'Your task creation failed.'
      render "edit"
    end
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'You have successfully edited the task!'
      redirect_to event_tasks_url(@event)
    else
      flash[:alert] = 'Your task edit failed.'
      render "edit"
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to event_tasks_url(@event), notice: 'Task was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description, :deadline)
    end
    def set_task
      @task = Task.find(params[:id])
    end

    def set_assignments
      @assignments = @task.assignments
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

end
