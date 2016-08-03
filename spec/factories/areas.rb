# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  project_id :integer
#  floor_plan :string
#  thumbnail  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :area do
    name "MyString"
    project nil
  end
end
