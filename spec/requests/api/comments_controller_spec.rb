require 'rails_helper'

RSpec.describe Api::CommentsController, type: :request do
  describe 'POST /features/:feature_id/comments' do
    let(:namespace) { '/api/features' }
    let(:feature) { create(:feature) }
    let(:valid_attributes) { { body: 'This is a comment' } }
    let(:invalid_attributes) { { body: '' } }

    context 'with valid parameters' do
      it 'creates a new comment' do
        expect do
          post "#{namespace}/#{feature.id}/comments", params: valid_attributes
        end.to change { Comment.count }.by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        expect do
          post "#{namespace}/#{feature.id}/comments", params: invalid_attributes
        end.to_not(change { Comment.count })

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
