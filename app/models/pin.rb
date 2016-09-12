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

class Pin < ApplicationRecord
    validates :x,
      presence: true,
      numericality: {
                      :greater_than_or_equal_to => 0.00000,
                      :less_than_or_equal_to => 1.00000 }
    validates :y,
      presence: true,
      numericality: {
                      :greater_than_or_equal_to => 0.00000,
                      :less_than_or_equal_to => 1.00000 }

    belongs_to :area
end
