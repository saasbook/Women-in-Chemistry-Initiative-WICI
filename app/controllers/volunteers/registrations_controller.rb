class Volunteers::RegistrationsController < Devise::RegistrationsController
  include Accessible
  before_action :set_volunteer, only: [:approve, :destroy]
  before_action :authenticate, only: [:approve, :index, :destroy]
  skip_before_action :check_user, except: [:new, :create]


  def index
    @volunteers = Volunteer.all.sort_by(:approved)
  end

  def approve
    @volunteer.approve
    redirect_to accounts_path, notice: "Volunteer approved."
  end

  def destroy
    @volunteer.destroy
    redirect_to accounts_path, notice: "Volunteer deleted." if @volunteer.destroy
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def authenticate
    redirect_to root_path if not admin_signed_in?
  end

end
