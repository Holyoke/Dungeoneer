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

class Area < ApplicationRecord
  mount_uploader :floor_plan, FloorPlanUploader
  belongs_to :project
end
