require 'rails_helper'

feature 'Sign in', :devise do
  scenario 'user cannot login if not registered' do
     sign_in('test@test.com', 'password')
     expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'user can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'user cannot sign in with an invalid email' do
    user = FactoryGirl.create(:user)
    sign_in('invalid@email.com', user.password)
    expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'user cannot sign in with an invalid password' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, 'invalidPassword')
    expect(page).to have_content 'Invalid email or password.'
  end
end
