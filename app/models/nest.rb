class Nest < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth_info)
    Nest.create(token: auth_info.credentials.token, expiration: auth_info.credentials.expires_at, user_id: current_user.id)
  end

  def client
    @client ||= Firebase::Client.new('https://developer-api.nest.com')
  end

  def response
    client.get('devices', { auth: token })
  end

  def response_hash
    response.body['thermostats'].extend Hashie::Extensions::DeepFind
  end

  def current_temperature
    @current_temperature ||= response_hash.deep_find('ambient_temperature_f')
  end

  def name
    @name ||= response_hash.deep_find('name')
  end
end
