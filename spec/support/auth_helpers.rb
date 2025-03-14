require 'devise/jwt/test_helpers'

module AuthHelpers
  def valid_headers(user)
    headers = { "Content-Type" => "application/json" }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end
