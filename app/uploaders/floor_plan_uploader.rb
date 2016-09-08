# encoding: utf-8

class FloorPlanUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :full_map do
    process :full_map_mogrify
  end

  version :thumb, from_version: :full_map do
    process :resize_to_fit => [150, 150]
  end

  def full_map_mogrify
    manipulate! do |img|
      img.format("png")
      img = yield(img) if block_given?
      img
    end
  end

  def filename
    "#{model.name}.png"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf)
  end
end
