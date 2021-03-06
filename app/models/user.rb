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

class User < ApplicationRecord

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :map_memberships
  has_many :invitations, class_name: "Invite", foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: "Invite", foreign_key: 'sender_id'
  has_many :maps, through: :map_memberships
  has_many :areas, through: :maps

  def admin?(map_id)
    membership = find_membership(map_id)
    membership.role == "admin"
  end

  def set_role(map_id, role)
    membership = find_membership(map_id)
    membership.role = role
    membership.save
  end

  def find_membership(map_id)
    MapMembership.where(user_id: self.id, map_id: map_id).first
  end
end
