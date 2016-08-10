require 'rails_helper'

feature 'Sign in', :devise do
  scenario 'user cannot login if not registered' do
     sign_in('test@test.com', 'password')
     expect(page).to have_content 'Invalid email or password'
  end
end
