class Leader < ApplicationRecord
validates :firstname, :lastname, presence: true, uniqueness: true
validates :image, file_size: { less_than: 1.megabytes }, presence: true
mount_uploader :image, ImageUploader

  def self.by_created
    Leader.all.order("created_at")
  end

end
