# encoding: utf-8

class FloorPlanUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :store_dimensions

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :full_map do
    process :full_map_mogrify
  end

  version :thumb, from_version: :full_map do
    process :resize_to_fill => [100, 100]
    process :convert => 'png'
    def full_filename (for_file = model.floor_plan.file)
      "#{model.name.html_safe}-thumb.png"
    end
  end

  def full_map_mogrify
    manipulate! do |img|
      img.format("png")
      img = yield(img) if block_given?
      img
    end
  end

  def filename
    "converted-#{model.name.html_safe}.png"
  end

  def extension_white_list
    %w(pdf)
  end

  private

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
