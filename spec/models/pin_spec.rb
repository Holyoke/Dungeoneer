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

require 'rails_helper'

RSpec.describe Pin, type: :model do
  it { should validate_presence_of(:x) }
  it { should validate_presence_of(:y) }
  it { should belong_to(:area) }

  it {should validate_numericality_of(:x).is_greater_than_or_equal_to(0.0).is_less_than_or_equal_to(1.0)}
  it {should validate_numericality_of(:y).is_greater_than_or_equal_to(0.0).is_less_than_or_equal_to(1.0)}
end
