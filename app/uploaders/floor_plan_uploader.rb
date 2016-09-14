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
    process :pdf_png_conversion
    def full_filename(for_file = model.floor_plan.file )
      "full_map.png"
    end
  end

  version :thumb, from_version: :full_map do
    process :thumbnail_conversion
    def full_filename(for_file = model.floor_plan.file )
      "thumb.png"
    end
  end


  def filename
    "#{model.name.html_safe}-uploaded.pdf"
  end

  def extension_white_list
    %w(pdf)
  end

  private

  def pdf_png_conversion
    manipulate! do |img|
      img.format("png")
      img
    end
    self.file.instance_variable_set(:@content_type, "image/png")
  end

  def thumbnail_conversion
    manipulate! do |img|
      img.format("png") do |combine|
        combine.resize "200x200"
      end
      img
    end
  end

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
