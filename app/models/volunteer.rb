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

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def approve
    self.approved = true
    self.save!
  end

  def self.list_by_approval
    Volunteer.all.order(:approved)
  end


  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

end
