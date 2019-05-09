class LeadersController < ApplicationController
  before_action :set_leader, only: [:edit, :update]


  def edit
  end

  def new
    @leader = Leader.new
  end

  def update
    respond_to do |format|
      if @leader.update(leader_params)
        format.html { redirect_to about_index_path, notice: 'Leader was successfully edited.' }
        format.json { render :index, status: :created, location: about_index_path }
      else
        format.html { render :new }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @leader = Leader.new(leader_params)
    respond_to do |format|
      if @leader.save
        format.html { redirect_to about_index_path, notice: 'Leader was successfully created.' }
        format.json { render :index, status: :created, location: about_index_path }
      else
        format.html { render :new }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_leader
    @leader = Leader.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leader_params
      params.require(:leader).permit(:id, :firstname, :lastname, :role, :image, :remove_image, :image_cache)
    end

end

