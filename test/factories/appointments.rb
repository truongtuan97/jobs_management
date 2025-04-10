FactoryBot.define do
  factory :appointment do
    doctor { nil }
    patient { nil }
    appointment_date { "2025-04-01 07:17:14" }
    status { "MyString" }
  end
end
