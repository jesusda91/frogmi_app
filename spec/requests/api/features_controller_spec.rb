require 'rails_helper'

RSpec.describe Api::FeaturesController, type: :request do
  let(:namespace) { '/api/features' }

  describe 'GET /features' do
    let(:features) { create_list(:feature, 10) }

    context 'when requesting all features' do
      it 'returns a success response and all features' do
        features
        get namespace
        expect(response).to have_http_status(:success)
        expect(json_response['data'].count).to eq(10)
      end
    end

    context 'when specifying page and per_page parameters' do
      it 'returns the correct number of features per page' do
        features
        get namespace, params: { page: 2, per_page: 5 }
        expect(json_response['data'].count).to eq(5)
        expect(json_response['pagination']['current_page']).to eq(2)
        expect(json_response['pagination']['per_page']).to eq(5)
      end
    end

    context 'when filtering by magnitude type' do
      let(:filtered_features) { create_list(:feature, 5, mag_type: 'ml') }

      it 'returns only features with the specified magnitude type' do
        filtered_features
        get namespace, params: { filters: { mag_type: 'ml' } }
        expect(json_response['data'].count).to eq(5)
        json_response['data'].each do |feature|
          expect(feature['attributes']['mag_type']).to eq('ml')
        end
      end
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
