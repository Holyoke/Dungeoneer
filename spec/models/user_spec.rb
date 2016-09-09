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
  let(:project) {FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user_with_projects) }

  describe '#set_role' do
    let(:project) {FactoryGirl.create(:project) }
    let(:user) { FactoryGirl.create(:user_with_projects) }

    it 'assigns role to project membership' do
      project_id = user.projects.first.id
      expect(user.find_membership(project_id).role).to eq("collaborator")
      user.set_role(project_id, "admin")
      expect(user.find_membership(project_id).role).to eq("admin")
    end
  end

  describe '#find_membership' do
    it 'finds project memberships' do
      project_id = user.projects.first.id
      expect(user.find_membership(project_id).role).to eq("collaborator")
    end
  end
end
