module Api
  module V1
    class FeaturesController < ApplicationController
      def index
        render json: { msg: 'index' }, status: :ok
      end

      def create
        render json: { msg: 'create' }, status: :ok
      end
    end
  end
end
