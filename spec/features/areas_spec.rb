require 'rails_helper'
require 'byebug'

feature 'CRUD Area Stories', :devise do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:map) { FactoryGirl.create(:map_with_areas, users: [user]) }

  before do
    login_as(user, scope: :user)
    user.set_role(map.id, "admin")
  end
  after { Warden.test_reset! }

  scenario 'User can create new areas' do
    visit new_map_area_path(map)
    fill_in('Name', with: 'New area name')
    fill_in('Description', with: 'New area decription')
    attach_file('Floor plan', File.join(Rails.root + 'sample_data/sample_floor_plan_small.pdf'))
    click_button('Save')
    expect(page).to have_content('Area was successfully created.')
  end

  scenario 'User sees a list of all areas under a map' do
    visit map_path(map)
    expect(page).to have_content("Areas of #{map.name}")
  end

  scenario 'User see specific area view' do
    area = map.areas.first

    visit area_path(area)
    expect(page).to have_content(area.name)
  end

  scenario 'User can upload a new pdf to an uploaded area' do
    visit edit_area_path(map.areas.first)
    fill_in('Name', with: 'Edited area name')
    fill_in('Description', with: 'Edited area decription')
    attach_file('Floor plan', File.join(Rails.root + 'sample_data/sample_floor_plan_small.pdf'))
    click_button('Save')
    expect(page).to have_content('Area was successfully updated.')
  end
end
