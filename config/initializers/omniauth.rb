# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_OAUTH2_CLIENT_ID"], ENV["GOOGLE_OAUTH2_CLIENT_SECRET"]
end

# TODO: configure callback_url
OmniAuth.config.full_host = Rails.env.production? ? "https://example.com" : "http://localhost:3000"
