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

FactoryGirl.define do
  factory :project_membership do
    project nil
    user nil

    factory :admin_project_memberships do
      role 'admin'

      after(:create) do |user_project, evaluator|
        create(:project, :with_area_and_pins, project_memberships: [user_project])
      end
    end

  end
end
