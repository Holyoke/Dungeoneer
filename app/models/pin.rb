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
    validates_presence_of :x
    validates_presence_of :y

    belongs_to :area
end
