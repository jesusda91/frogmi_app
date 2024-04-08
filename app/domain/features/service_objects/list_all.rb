module Features
  module ServiceObjects
    class ListAll
      def initialize(
        params,
        callbacks,
        repositories = {
          features_repository: Features::Repositories::FeaturesRepository
        }
      )
        @filters = params[:filters] || {}
        @page = params[:page].try(:to_i) || 1
        @per_page = params[:per_page].try(:to_i) || 10
        @callbacks = callbacks
        @features_repository = repositories[:features_repository]
      end

      def call
        return callbacks[:failure].call('per_page must be <= 1000.') if invalid_per_page?

        features = features_repository.paginate(filter_conditions, per_page, page)

        response = {
          data: serialize_features(features),
          pagination: {
            current_page: page,
            total: features_repository.count,
            per_page: per_page
          }
        }

        callbacks[:success].call(response)
      end

      private

      attr_reader :filters, :page, :per_page, :callbacks, :features_repository

      def invalid_per_page?
        per_page > 1000
      end

      def filter_conditions
        conditions = {}
        conditions[:mag_type] = filters[:mag_type].try(:split, ',') if filters[:mag_type].present?
        conditions
      end

      def serialize_features(features)
        features.map do |feature|
          {
            id: feature.id,
            type: 'feature',
            attributes: {
              external_id: feature.external_id,
              magnitude: feature.magnitude,
              place: feature.place,
              time: feature.time.to_s,
              tsunami: feature.tsunami,
              mag_type: feature.mag_type,
              title: feature.title,
              coordinates: {
                longitude: feature.longitude,
                latitude: feature.latitude
              }
            },
            links: {
              external_url: feature.url
            }
          }
        end
      end
    end
  end
end
