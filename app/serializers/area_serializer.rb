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

class AreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :floor_plan, :description, :created_at, :updated_at, :width, :height

  belongs_to :map
end
