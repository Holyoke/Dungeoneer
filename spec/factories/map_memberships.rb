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

FactoryGirl.define do
  factory :map_membership do
    map nil
    user nil

    factory :admin_map_memberships do
      role 'admin'

      after(:create) do |user_map, evaluator|
        create(:map, :with_area_and_pins, map_memberships: [user_map])
      end
    end

  end
end
