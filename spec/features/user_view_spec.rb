require 'rails_helper'

describe 'the_application', type: :feature do
  before(:each) do
    @user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  context 'dashboard' do
    before(:each) do
      visit dashboard_index_path
    end

    it 'has a dashboard page' do
      expect(page).to have_css('nav')
    end

    it 'has a link to the settings path' do
      click_on('settings')

      expect(current_path).to eq(settings_path)
    end

    it 'shows last feeding and next scheduled on dashboard' do
      pet_feeder = @user.pet_feeders.create(name: 'Feeder 1', url: 'http://www.example.com', last_feeding: 1.hour.ago)
      feed_time = pet_feeder.feed_times.create(time: 1.hour.from_now)

      visit dashboard_index_path
      expect(page).to have_content(pet_feeder.last_feeding.strftime('%-l:%M%p'))
      expect(page).to have_content(feed_time.time.strftime('%-l:%M%p'))
    end
  end

  context 'settings' do
    before(:each) do
      visit settings_path
    end

    it 'has a link to add a video feed' do
      expect(page).to have_link 'Add New Video Feed'
    end

    it 'has a link to add pet feeder' do
      expect(page).to have_link 'Add New Pet Feeder'
    end

    it 'has a link to add a nest' do
      expect(page).to have_link 'Authorize Nest Connect'
    end

    it 'has a link to a feed time when there is a pet feeder' do
      @user.pet_feeders.create(name: 'feeder', url: 'http://my-aweseome-feeder.com')

      visit settings_path
      expect(page).to have_link('playlist_add')
    end

    it 'shows video feeds' do
      @user.video_feeds.create(location: 'Living Room', url: 'http://www.example.com')

      visit settings_path
      expect(page).to have_content('Living Room')
    end

    it 'shows pet feeders and feed times' do
      pet_feeder = @user.pet_feeders.create(name: 'Feeder 1', url: 'http://www.example.com')
      pet_feeder.feed_times.create(time: '12:00')

      visit settings_path
      expect(page).to have_content('Feeder 1')
      expect(page).to have_content('12:00PM')
    end


    it 'has a link to the dashboard' do
      click_on('Dashboard')

      expect(current_path).to eq(dashboard_index_path)
    end
  end
end
