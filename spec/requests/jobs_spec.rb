require 'rails_helper'

RSpec.describe "Jobs API", type: :request do

  let!(:user) { create(:user) }
  let!(:company) { create(:company) }
  let!(:jobs) { create_list(:job, 3, company: company, user: user) }
  let(:job_id) { jobs.first.id }
  let(:headers) { valid_headers(user) }

  describe "GET /api/v1/jobs" do
    before { get '/api/v1/jobs', headers: headers }

    it "return jobs" do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(JSON.parse(response.body)["jobs"]).size).to eq(3)
    end

    it "return sttus code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/jobs" do
    let(:valid_attributes) {
      { title: "Backend Developer", description: "Ruby on Rails Developer", company_id: company.id, salary: 5000 }.to_json
    }

    context "when request is valid" do
      before { post "/api/v1/jobs", params: valid_attributes, headers: headers }

      it "create a job" do
        expect(JSON.parse(response.body)['job']['title']).to eq("Backend Developer")
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context "when request is invalid" do
      before { post "/api/v1/jobs", params: { title: nil }.to_json, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end

  end
end