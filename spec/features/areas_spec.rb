require 'rails_helper'

feature 'CRUD Area Stories', :devise do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project_with_areas, user: user) }

  before { login_as(user, scope: :user) }
  after { Warden.test_reset! }

  scenario 'User can create new areas' do
    visit new_project_area_path(project)
    save_and_open_page
  end

  scenario 'User sees a list of all areas under a project' do
    visit project_path(project)
    expect(page).to have_content("Areas of #{project.name}")
  end

  scenario 'User see specific area view' do
    area = project.areas.first

    visit area_path(area)
    expect(page).to have_content(area.name)
  end

  scenario 'User can upload a new pdf to an area' do

  end

  scenario 'User can destroy their areas'
end
