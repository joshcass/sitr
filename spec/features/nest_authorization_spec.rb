require 'rails_helper'
require 'helpers/login_helper'

describe 'the_application', type: :feature do
  before(:each) do
    @user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit settings_path
  end

  it 'has a link to authorize nest' do
    expect(page).to have_link("Authorize Nest Connect", href: '/auth/nest')
  end

  it 'can authorize a nest' do
    stub_omniauth

    click_on('Authorize Nest Connect')
    expect(Nest.all.count).to eq 1

    @user = User.find(@user.id)
    expect(@user.nest).to  be_a(Nest)
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:nest] = OmniAuth::AuthHash.new({
      provider: 'nest',
      credentials: {
        token: 1233456,
        expires_at: 123456
      }
    })
  end
end
