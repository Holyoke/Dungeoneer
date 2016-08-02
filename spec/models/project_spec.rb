# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  license    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it "requires a name" do
    expect(FactoryGirl.build(:project)).to be_valid
    expect(FactoryGirl.build(:project, name: '')).to_not be_valid
  end
end
