class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [800, 800]

  version :index do
    process resize_to_fit: [350,nil]
  end

  version :thumb do
    process resize_to_fill: [100,100]
  end

  version :leader do
    process resize_to_fill: [150,150]
  end

  version :home do
    process resize_to_fill: [350,300]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [25, 25]
  end

  def default_url(*args)
    "default.png"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
