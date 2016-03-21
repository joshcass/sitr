require 'rails_helper'

describe 'the_application', type: :feature do
  context 'when logged out' do
    before(:each) do
      visit root_path
    end

    it 'has a login link' do
      expect(page).to have_button("Login or Signup")
    end

    it 'does not have logout link' do
      expect(page).to_not have_link("#logout", href: logout_path)
    end
  end

  context 'when logged in' do

    before(:each) do
      user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_index_path
    end

    it 'redirects to the dashboard and has the nav bar' do
      expect(page).to have_css('nav')
    end

    it 'does not have login link' do
      expect(page).to_not have_link("Login or signup with twitter", href: login_path)
    end
  end
end
