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

  context 'the full map version' do
    it "converts a pdf into a png" do
      expect(uploader.full_map.url).to be_present
    end
  end
end
