# == Schema Information
#
# Table name: areas
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  project_id  :integer
#  floor_plan  :string
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  width       :float            not null
#  height      :float            not null
#

class Area < ApplicationRecord
  # potentially have many floorplans in the future may want create a new model
  # for floorplans
  mount_uploader :floor_plan, FloorPlanUploader
  belongs_to :project
  has_many :pins, dependent: :destroy

  validates :name, presence: true
  validates_presence_of :floor_plan

end
