require 'rails_helper'

feature 'Project Admin Stories', :devise do
  scenario 'user can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Admin can see their projects' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password
    expect(page).to have_content 'Projects'
  end

  scenario 'Admin can edit project description'

  scenario 'Admin can add other collaborators'
end
