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

require 'rails_helper'

describe Invite, type: :model do
  describe 'before_create' do
    it 'generates a token' do
      invite = Invite.new
      invite.save
      expect(invite.token).to match(/\b([a-f0-9]{40})\b/)
    end
  end
end
