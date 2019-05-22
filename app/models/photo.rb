class Photo < ApplicationRecord
  validates :image, file_size: { less_than: 1.megabytes }
  mount_uploader :image, ImageUploader
end
