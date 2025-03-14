FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    jti { SecureRandom.uuid }  # Thêm dòng này để tránh lỗi "Missing jti"
  end
end