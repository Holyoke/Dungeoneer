# == Schema Information
#
# Table name: maps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#

FactoryGirl.define do
  factory :map do
    name "Test_Map"

    factory :map_with_areas do
      transient do
        areas_count 2
      end

      after(:create) do |map, evaluator|
        create_list(:area, evaluator.areas_count, map: map)
      end
    end

    trait :with_area_and_pins do
      after(:create) do |map, evaluator|
        create(:area, :with_pins, map: map)
      end
    end

  end
end
