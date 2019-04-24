class Message
  include ActiveModel::Model
  attr_accessor :name, :email, :body

  validates :name, :body, presence: true
  validates :email, presence: true, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
end
