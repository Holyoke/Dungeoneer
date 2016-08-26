# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  license     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Project < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :areas, dependent: :destroy

  has_many :project_memberships
  has_many :collaborators, :through => :project_memberships, :source => :users
end
