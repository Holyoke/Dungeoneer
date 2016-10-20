# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default("")
#  authentication_token   :string(30)
#

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    factory :user_with_maps do
      transient do
        maps_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:map, evaluator.maps_count, users: [user])
      end
    end

    factory :admin_with_maps do
      transient do
        maps_count 2
      end

      after(:create) do |admin, evaluator|
        create_list(:admin_map_memberships, evaluator.maps_count, user: admin)
      end
    end
  end
end
