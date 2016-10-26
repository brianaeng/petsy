
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
  ENV["GITHUB_CLIENT_ID"],
  ENV["GITHUB_CLIENT_SECRET"],
  scope: "user:email"   # Make sure You set the Authorization callback URL: http://localhost:3000/auth/github/callback when you 
end
