require 'rails_helper'

RSpec.describe "Applications API", type: :request do
  let!(:user) { create(:user) }
  let!(:company) { create(:company) }
  let!(:job) { create(:job, company_id: company.id, user: user) }
  let!(:applications) { create_list(:application, 2, job: job, user: user) }
  let(:application_id) { applications.first.id }
  let(:headers) { valid_headers(user) }

  describe "GET /api/v1/applications" do
    before { get "/api/v1/applications", headers: headers }

    it "returns applications" do
      expect(json(response.body)).not_to be_empty
      expect(JSON.parse(json(response.body)['applications']).size).to eq(2)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/applications" do
    let(:valid_attributes) { { job_id: job.id, status: "pending", cover_letter: "I'm interested" }.to_json }

    context "when request is valid" do
      before { post "/api/v1/applications", params: valid_attributes, headers: headers }

      it "creates an application" do
        expect(json(response.body)['application']['status']).to eq("pending")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end
end
