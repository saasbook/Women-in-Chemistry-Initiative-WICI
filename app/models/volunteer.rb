class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments, dependent: :destroy
  has_many :tasks, :through => :assignments
  has_many :events, :through => :tasks
  validates :firstname, :lastname, :presence => true

  def can_signup?(task)
    !self.tasks.include?(task) && (task.deadline.nil? || task.deadline > Date.current)
  end

  def can_destroy?(item)
    if item.instance_of?(Assignment)
      self.id == item.volunteer_id && (item.task.deadline.nil? || item.task.deadline > Date.current)
    else
      false
    end
  end
end
