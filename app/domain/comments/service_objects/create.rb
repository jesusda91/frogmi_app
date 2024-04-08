module Comments
  module ServiceObjects
    class Create
      def initialize(
        params,
        callbacks,
        repositories = {
          comments_repository: Comments::Repositories::CommentsRepository,
          features_repository: Features::Repositories::FeaturesRepository
        }
      )
        @feature_id = params[:feature_id]
        @body = params[:body]
        @callbacks = callbacks
        @comments_repository = repositories[:comments_repository]
        @features_repository = repositories[:features_repository]
      end

      def call
        feature = Feature.find(feature_id)
        return callbacks[:failure].call('comment body is required') if body.blank?

        comment = comments_repository.create(feature: feature, body: body)

        callbacks[:success].call(comment)
      rescue ActiveRecord::RecordNotFound
        callbacks[:failure].call("Feature with ID #{feature_id} not found")
      end

      private

      attr_reader :feature_id, :body, :callbacks, :comments_repository, :features_repository

    end
  end
end
