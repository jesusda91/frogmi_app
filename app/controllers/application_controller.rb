class ApplicationController < ActionController::API
  ERROR_MESSAGE = 'An error has occurred, please try again'.freeze

  private

  def callbacks
    { success: success_response, failure: error_response }
  end

  def success_response
    lambda do |result, status = :ok|
      render json: result, status: status
    end
  end

  def error_response
    lambda do |error_message = ERROR_MESSAGE, status = :unprocessable_entity|
      render json: { error: error_message }, status: status
    end
  end
end
