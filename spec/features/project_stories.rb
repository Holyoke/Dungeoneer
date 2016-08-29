require 'rails_helper'

feature 'CRUD Project Stories', :devise do
  let(:user_1) { FactoryGirl.create(:user, email: 'user1@jobwalk.com') }
  let(:user_2) { FactoryGirl.create(:user, email: 'user2@jobwalk.net') }
  before { login_as(user_1, scope: :user) }
  after { Warden.test_reset! }

  scenario 'User can create new projects' do

  end

  scenario 'User only sees their projects' do
    #Seed user 1 and user 2
    4.times do |idx|
      if idx % 2 == 0
        user_1.projects.create(
                name: "User 1's project",
                license: 'dummytext',
                description: "#{user_1.email}'s project'"
                )
      else
        user_2.projects.create(
                name: "User 2's project",
                license: 'dummytext',
                description: "#{user_2.email}'s project'"
                )
      end
    end

    #expect only user 1's projects to show up
    visit projects_path
    expect(page).to_not have_content("User 2's project")
    expect(page).to have_content("User 1's project")
  end

  scenario 'User can edit project description'

  scenario 'User can destroy their projects'
end
