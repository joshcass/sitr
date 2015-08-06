require 'rails_helper'

class FakeSessionsController < ApplicationController
  skip_before_action :authorize
  def create
    session[:user_id] = params[:user_id]
    redirect_to dashboard_index_path
  end
end

describe 'the_application', type: :feature do
  context 'when logged out' do
    before(:each) do
      visit root_path
    end

    it 'has a login link' do
      expect(page).to have_link("Login or signup with twitter", href: login_path)
    end

    it 'does not have logout link' do
      expect(page).to_not have_link("#logout", href: logout_path)
    end
  end

  context 'when logged in' do
    before(:each) do
      Rails.application.routes.draw do
        root to: 'welcome#index'
        get '/fake_login' => 'fake_sessions#create', as: :fake_login
        get '/login' => redirect('/auth/twitter'), as: :login
        delete '/logout' => 'sessions#destroy', as: :logout
        resources :dashboard, only: [:index]
        resources :settings, only: [:index]
      end
      user = User.create(name: "Boba Fett", screen_name: "bobafett", uid: '1234')
      visit fake_login_path(user_id: user.id)
    end

    after(:each) do
      Rails.application.reload_routes!
    end

    it 'redirects to the dashboard and has the nav bar' do
      expect(current_path).to eq('/dashboard')
      expect(page).to have_css('nav')
    end

    it 'does not have login link' do
      expect(page).to_not have_link("Login or signup with twitter", href: login_path)
    end
  end
end

