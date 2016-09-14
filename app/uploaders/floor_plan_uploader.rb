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
    process :convert => 'png'
    process :resize_to_fill => [100, 100]
    def full_filename(for_file = model.floor_plan.file )
      "thumb.png"
    end
  end


  def filename
    "uploaded-#{model.name.html_safe}.pdf"
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
    self.file.instance_variable_set(:@content_type, "application/png")
  end

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
