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
#  role         :integer          default("collaborator"), not null
#  accepted     :boolean          default(FALSE)
#

class Invite < ApplicationRecord
  enum role: [:collaborator, :admin]

  belongs_to :project
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  before_create :generate_token
  before_save :check_user_existence

  def accept_invitation
    self.accepted = true
    self.recipient.projects.push(self.project)
    self.save
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end
end
