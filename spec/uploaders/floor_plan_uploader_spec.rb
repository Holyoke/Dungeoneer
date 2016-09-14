require 'rails_helper'
require 'carrierwave/test/matchers'

describe FloorPlanUploader do
  include CarrierWave::Test::Matchers

  let(:area) { FactoryGirl.build(:area) }
  let(:uploader) { FloorPlanUploader.new(area, :floor_plan) }

  before do
    FloorPlanUploader.enable_processing = true
    File.open(File.join(Rails.root, 'spec', 'sample_data', 'sample_floor_plan_small.pdf')) { |f| uploader.store!(f) }
  end

  after do
    FloorPlanUploader.enable_processing = false
    uploader.remove!
  end

  context 'Floor plan uploader' do
    it "converts a pdf into a full map png" do
      expect(uploader.full_map.url).to be_present
      expect(uploader.full_map.content_type).to eq('image/png')
    end

    it "has a thumbnail" do
      expect(uploader.thumb.url).to be_present
      expect(uploader.thumb.content_type).to eq('image/png')
    end

    it 'stores dimensions of a photo' do
      expect(uploader.model.width).to eq(3024.0)
      expect(uploader.model.height).to eq(2160.0)
    end
  end
end
