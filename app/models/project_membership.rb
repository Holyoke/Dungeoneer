# == Schema Information
#
# Table name: project_memberships
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("collaborator"), not null
#

class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum role: [:collaborator, :admin]
end
