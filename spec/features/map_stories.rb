require 'rails_helper'

feature 'CRUD Map Stories', :devise do
  let(:user_1) { FactoryGirl.create(:user, email: 'user1@dungeoneer.com') }
  let(:user_2) { FactoryGirl.create(:user, email: 'user2@dungeoneer.net') }
  before { login_as(user_1, scope: :user) }
  after { Warden.test_reset! }

  scenario 'User only sees their maps' do
    #Seed user 1 and user 2
    4.times do |idx|
      if idx % 2 == 0
        user_1.maps.create(
                name: "User 1's map",
                license: 'dummytext',
                description: "#{user_1.email}'s map'"
                )
      else
        user_2.maps.create(
                name: "User 2's map",
                license: 'dummytext',
                description: "#{user_2.email}'s map'"
                )
      end
    end

    #expect only user 1's maps to show up
    visit maps_path
    expect(page).to_not have_content("User 2's map")
    expect(page).to have_content("User 1's map")
  end
end
