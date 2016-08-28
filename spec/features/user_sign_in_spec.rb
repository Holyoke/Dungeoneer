require 'rails_helper'

feature 'User Signs in to their Home Page', :devise do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, scope: :user)
    visit '/'
  end

  after { Warden.test_reset! }

  scenario 'User has a link to create new Projects' do
    page.should have_selector(:link_or_button, 'Create a new Project')
  end

  scenario 'User has a link towards Projects index' do
    page.should have_selector(:link_or_button, 'View Projects')
  end
end
