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
#  user_id     :integer
#

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :license, :created_at, :updated_at, :description

  has_many :areas
end
