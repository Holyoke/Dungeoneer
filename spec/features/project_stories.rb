require 'rails_helper'

feature 'CRUD Project Stories', :devise do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
  after { Warden.test_reset! }

  scenario 'User can create new projects' do
    visit '/'
    expect(page).to have_content 'Projects'
  end

  scenario 'User can edit project description'

  scenario 'User can destroy their projects'
end
