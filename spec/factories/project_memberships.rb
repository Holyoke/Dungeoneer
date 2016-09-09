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

FactoryGirl.define do
  factory :project_membership do
    project nil
    user nil
  end
end
