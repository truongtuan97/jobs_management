FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }  # Đảm bảo tên không bị trùng
    description { "A sample company" }
    location { "New York" }
  end
end
