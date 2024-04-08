module Api
  module V1
    class FeaturesController < ApplicationController
      def index
        Features::ServiceObjects::ListAll.new(list_params, callbacks).call
      end

      def create
        render json: { msg: 'create' }, status: :ok
      end

      private

      def list_params
        params.permit(:page, :per_page, filters: [:mag_type])
      end
    end
  end
end
