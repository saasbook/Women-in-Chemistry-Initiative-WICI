class PhotosController < ApplicationController
  before_action :set_photo, only: [:edit, :update, :destroy]
  # before_action :authenticate_admin!, except: [:index]
  # GET /events
  # GET /events.json
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def home
    @photos = Photo.all
    @num_cols = 3
    @value = 1
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_url, notice: 'Photo was successfully created.' }
        format.json { render :index }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photos_url, notice: 'Photo was successfully updated.' }
        format.json { render :index }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:id, :description, :image, :remove_image, :image_cache)
    end
end
