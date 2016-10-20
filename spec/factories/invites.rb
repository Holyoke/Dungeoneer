# == Schema Information
#
# Table name: invites
#
#  id           :integer          not null, primary key
#  email        :string
#  map_id       :integer
#  sender_id    :integer
#  recipient_id :integer
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  role         :integer          default("collaborator"), not null
#  accepted     :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :invite do
    
  end
end
