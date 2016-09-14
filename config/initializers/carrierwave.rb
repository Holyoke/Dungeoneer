CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
  elsif Rails.env.test?
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp/spec"
  else
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                => ENV['AWS_REGION']
    }
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  config.fog_directory    = ENV['S3_BUCKET_NAME']
  config.asset_host = ActionController::Base.asset_host
end

#Seperates rspec test uploads
CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?
  klass.class_eval do
    def cache_dir
      "#{Rails.root}/spec/support/uploads/tmp"
    end

    def store_dir
      "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
