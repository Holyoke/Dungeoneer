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
#

require 'rails_helper'

RSpec.describe Area, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:project) }
end
