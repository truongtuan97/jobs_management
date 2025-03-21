require 'rails_helper'

RSpec.describe "AudiLog API", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { valid_headers(user) }
  # let!(:company) { create(:company) }
  # let!(:jobs) { create_list(:job, 3, company: company, user: user) }
  let!(:audit_log) { AuditLog.create(action: "created", user_id: user.id, details: { job_id: 1, job_title: 'job title' }) }
  
  it 'get list audit logs' do
    get '/api/v1/auditlogs', headers: headers

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to be > 0
  end

end