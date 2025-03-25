require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  let!(:user) { create(:user) }
  let!(:company) { create(:company) } 
  let!(:jobs) { create_list(:job, 3, company: company, user: user) }
  let(:job_id) { jobs.first.id }
  let(:headers) { valid_headers(user) }

  describe 'GET /api/v1/jobs' do
    before do
      get '/api/v1/jobs', headers: headers
    end

    it 'returns jobs' do
      expect(JSON.parse(JSON.parse(response.body)['jobs']).size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/jobs' do
    let(:valid_attributes) do
      { title: 'Backend Developer', description: 'Ruby on Rails Developer', company_id: company.id,
        salary: 5000 }.to_json
    end

    context 'when request is valid' do
      before do
        allow(Job).to receive(:create!).and_return(build_stubbed(:job, title: 'Backend Developer'))
        post '/api/v1/jobs', params: valid_attributes, headers: headers
      end

      it 'creates a job' do
        expect(JSON.parse(response.body)['job']['title']).to eq('Backend Developer')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before do
        allow(Job).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        post '/api/v1/jobs', params: { title: nil }.to_json, headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
