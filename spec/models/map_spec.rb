# == Schema Information
#
# Table name: maps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe Map, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:users) }
  it { should have_many(:areas) }
end
