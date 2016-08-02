require 'rails_helper'

RSpec.describe Project, type: :model do
  it "requires a name" do
    expect(FactoryGirl.build(:project)).to be_valid
    expect(FactoryGirl.build(:project, name: '')).to_not be_valid
  end
end
