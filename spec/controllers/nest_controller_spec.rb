require 'rails_helper'

describe NestController do
  let!(:user) { User.create(email: "email@example.com", time_zone: 'UTC', password: 'password') }
  let!(:nest) { Nest.create(token: 'c.12345', expiration: 122334, user_id: user.id) }

  before(:each) do
    session[:user_id] = user.id
  end

  context '#destroy' do
    it 'can delete a nest' do
      expect {
        delete :destroy, id: nest.id
      }.to change{Nest.count}.from(1).to(0)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end
end
