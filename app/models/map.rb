# == Schema Information
#
# Table name: maps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  license     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#

class Map < ApplicationRecord
  validates :name, presence: true

  has_many :invites
  has_many :areas, dependent: :destroy
  has_many :map_memberships
  has_many :users, through: :map_memberships
end
