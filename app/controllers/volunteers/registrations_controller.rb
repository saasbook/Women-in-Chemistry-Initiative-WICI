class Volunteers::RegistrationsController < Devise::RegistrationsController
  include Accessible
  before_action :set_volunteer, only: [:approve, :destroy]
  before_action -> {authenticate_admin!(force: true)}, only: [:approve, :destroy]
  skip_before_action :check_user, except: [:new, :create]

  def approve
    @volunteer.approve
    redirect_to accounts_path, notice: "Volunteer approved."
  end

  def destroy
    @volunteer.destroy
    redirect_to accounts_path, notice: "Volunteer deleted."
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

end
