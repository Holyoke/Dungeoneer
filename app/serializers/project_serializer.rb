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

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :license, :description, :created_at, :updated_at

  has_many :areas
end
