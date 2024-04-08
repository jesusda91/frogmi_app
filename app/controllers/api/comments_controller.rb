module Api
  class CommentsController < ApplicationController
    def create
      Comments::ServiceObjects::Create.new(comment_params, callbacks).call
    end

    private

    def comment_params
      params.permit(:body, :feature_id)
    end
  end
end
