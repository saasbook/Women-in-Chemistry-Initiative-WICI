class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments
  has_many :tasks, :through => :assignments
  has_many :events, :through => :tasks
  validates :firstname, :lastname, :presence => true
  before_destroy :destroy_assignments

  def destroy_assignments
    self.assignments.destroy_all
  end

end
