Rails.application.config.middleware.use OmniAuth::Builder do
  provider :nest, Figaro.env.nest_id, Figaro.env.nest_secret
end
