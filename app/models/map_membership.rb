# == Schema Information
#
# Table name: map_memberships
#
#  id         :integer          not null, primary key
#  map_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("collaborator"), not null
#

class MapMembership < ApplicationRecord
  belongs_to :map
  belongs_to :user

  enum role: [:collaborator, :admin]
end
