class TodolistController < ApplicationController
	def index
		@todolist = Todolist.all
	end
	def show
  	end
	def new
		@todo = Todolist.new
	end
	def create
    	@todo = Todolist.new(todo_params)

	    respond_to do |format|
	      if @todo.save
	        format.html { redirect_to @todo, notice: 'TODO was successfully created.' }
	        format.json { render :show, status: :created, location: @todo }
	      else
	        format.html { render :new }
	        format.json { render json: @todo.errors, status: :unprocessable_entity }
	      end
	    end
  	end
  	def destroy
    	@todo.destroy
    	respond_to do |format|
      		format.html { redirect_to todolist_index_url, notice: 'TODO was successfully destroyed.' }
      		format.json { head :no_content }
   		end
  	end
  	private
	  	def todo_params
	  		params.require(:todolist).permit(:event_name, :event_date, :description)
	  	end
end