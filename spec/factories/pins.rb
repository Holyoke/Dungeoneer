# == Schema Information
#
# Table name: pins
#
#  id          :integer          not null, primary key
#  x           :float
#  y           :float
#  description :string
#  area_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :pin do
    x 0.5
    y 0.5
    description "Test Pin"
  end
end
