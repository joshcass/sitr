  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, Figaro.env.twitter_key, Figaro.env.twitter_secret
    provider :nest, Figaro.env.nest_id, Figaro.env.nest_secret
end
