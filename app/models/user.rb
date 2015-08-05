class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.id_str)
      user
    else
      user = create({name: auth_info.extra.raw_info.name,
        screen_name: auth_info.extra.raw_info.screen_name,
        uid: auth_info.extra.raw_info.id_str,
      })
      user
    end
  end
end
