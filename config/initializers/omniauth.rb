Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_API_KEY"], ENV["TWITTER_API_SECRET"], callback_url: "	https://127.0.0.1:3000/users/auth/twitter/callback"
end