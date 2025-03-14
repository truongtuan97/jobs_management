require 'rails_helper'

RSpec.describe 'Companies API', type: :request do
  include AuthHelpers
  
  let!(:user) { create(:user) }
  let!(:companies) { create_list(:company, 5) }
  let(:company_id) { companies.first.id }
  let(:headers) { valid_headers(user) } # Truyền user vào valid_headers   

  describe 'GET /api/v1/companies' do
    before { get '/api/v1/companies', headers: headers }

    it 'return companies' do
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
      expect(JSON.parse(response.body)['companies'].size).to eq(5)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/companies' do
    let(:valid_attributes) { { name: 'New Company', description: 'A startup', location: 'NYC', website: 'https://newcompany.com' }.to_json }

    context 'when request is valid' do
      before { post '/api/v1/companies', params: valid_attributes, headers: headers }

      it 'creates a company' do
        parsed_json = JSON.parse(response.body)
        expect(parsed_json['company']['name']).to eq('New Company')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/companies', params: { name: nil }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
