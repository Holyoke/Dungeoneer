# == Schema Information
#
# Table name: invites
#
#  id           :integer          not null, primary key
#  email        :string
#  project_id   :integer
#  sender_id    :integer
#  recipient_id :integer
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Invite < ApplicationRecord

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
  end
end
