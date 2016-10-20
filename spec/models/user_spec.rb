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

require 'rails_helper'

describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user_with_maps) }
  let(:map) { user.maps.first }

  describe '#set_role' do
    it 'assigns role to map membership' do
      map_id = user.maps.first.id
      expect(user.find_membership(map_id).role).to eq("collaborator")
      user.set_role(map_id, "admin")
      expect(user.find_membership(map_id).role).to eq("admin")
    end
  end

  describe '#find_membership' do
    it 'finds map memberships' do
      map_id = user.maps.first.id
      expect(user.find_membership(map_id).role).to eq("collaborator")
    end
  end
end
