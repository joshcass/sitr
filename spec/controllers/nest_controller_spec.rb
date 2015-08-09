require 'rails_helper'

describe NestController do
  before(:each) do
    user = User.create(name: "Boba Fett", screen_name: "bobafett", uid: '1234')
    @nest = Nest.create(token: 'c.12345', expiration: 122334, user_id: user.id)
    session[:user_id] = user.id
  end

  context '#destroy' do
    it 'can delete a nest' do
      expect {
        delete :destroy, id: @nest.id
      }.to change{Nest.count}.from(1).to(0)

      expect(response.status).to eq(302)
      expect(response).to redirect_to(settings_path)
    end
  end
end
