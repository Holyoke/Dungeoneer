# == Schema Information
#
# Table name: project_memberships
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("collaborator")
#

require 'rails_helper'

RSpec.describe ProjectMembership, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
