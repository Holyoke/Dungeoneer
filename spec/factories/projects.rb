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

    factory :project_with_areas_and_pins do
      transient do
        areas_count 2
        pins_count 3
      end

      after(:create) do |project, evaluator|
        pins = build_list(:pin, evaluator.pins_count)
        create_list(:area, evaluator.areas_count, project: project, pins: pins)
      end
    end
  end
end
