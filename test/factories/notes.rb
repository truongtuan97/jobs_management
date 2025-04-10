FactoryBot.define do
  factory :note do
    body { "MyText" }
    noteable { nil }
  end
end
