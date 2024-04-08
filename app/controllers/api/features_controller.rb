module Api
  class FeaturesController < ApplicationController
    def index
      filters = { mag_type: list_params[:mag_type] || list_params.try(:[], :filters).try(:[], :mag_type) }
      Features::ServiceObjects::ListAll.new({ **list_params, filters: filters }.with_indifferent_access, callbacks).call
    end

    private

    def list_params
      params.permit(:page, :per_page, :mag_type, filters: [:mag_type])
    end
  end
end
