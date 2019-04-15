class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :tasks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments, dependent: :destroy
  has_many :tasks, :through => :assignments
  has_many :events, :through => :tasks
  validates :firstname, :lastname, :presence => true

end
