# == Schema Information
#
# Table name: areas
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  map_id      :integer
#  floor_plan  :string
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  width       :float            not null
#  height      :float            not null
#

FactoryGirl.define do
  factory :area do
    name "Test Area"
    description "Foo"
    floor_plan { Rack::Test::UploadedFile.new(File.join(Rails.root,'sample_data', 'sample_floor_plan_small.pdf' )) }

    trait :with_pins do
      after(:create) do |instance|
        create_list(:pin, 3, area: instance)
      end
    end

  end
end
