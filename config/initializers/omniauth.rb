Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets.TWITTER_API_KEY, Rails.application.secrets.TWITTER_SECRET_KEY
end
