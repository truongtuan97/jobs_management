FactoryBot.define do
  factory :audit_log do
    action { 'job_created' }
    user_id { 1 }
    details { { job_id: 1001, title: 'Job title' } }
  end
end