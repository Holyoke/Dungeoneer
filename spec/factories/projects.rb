# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  license     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#

FactoryGirl.define do
  factory :project do
    name "Test_Project"

    factory :project_with_areas do
      transient do
        areas_count 2
      end

      after(:create) do |project, evaluator|
        create_list(:area, evaluator.areas_count, project: project)
      end
    end

    trait :with_area_and_pins do
      after(:create) do |project, evaluator|
        create(:area, :with_pins, project: project)
      end
    end

  end
end
