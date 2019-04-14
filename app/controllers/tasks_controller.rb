class TasksController < ApplicationController
  before_action :set_task, only: [:destroy]
  before_action :set_event

  def new
    @task = Task.new
  end

  def show
    puts @event
    @task = Task.where(:event_id => @event.id)
    puts @task
    if !@task
      redirect_to new_event_task_url
    end
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.event = @event


    if @task.save
      flash[:notice] = 'You have successfully added a new task!'
      redirect_to event_path(@event)
    else
      flash[:alert] = 'Your registration failed, please make sure your information is correct.'
      render "new"
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Task was successfully removed.' }
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

    def set_event
      @event = Event.find(params[:event_id])
    end
end
