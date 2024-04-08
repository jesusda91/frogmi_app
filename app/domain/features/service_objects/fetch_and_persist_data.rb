module Features
  module ServiceObjects
    # This class is responsible for fetching earthquake data from a remote source
    # and persisting it to the database.
    #
    # It uses the HTTParty gem to fetch data from the USGS earthquake data feed
    # and ActiveRecord to persist the fetched data into the 'features' table.
    class FetchAndPersistData
      include HTTParty

      base_uri 'https://earthquake.usgs.gov'
      BATCH_SIZE = 100

      def fetch_and_persist_data
        response = self.class.get('/earthquakes/feed/v1.0/summary/all_month.geojson')
        return unless response.success?

        data = JSON.parse(response.body)
        features = data['features']

        features.each_slice(BATCH_SIZE) do |batch_features|
          insert_batch(batch_features)
        end
      end

      private

      def insert_batch(batch_features)
        batch_data = build_batch_data(batch_features)

        external_ids = batch_data.pluck(:external_id)
        existing_ids = features_repository.existing_external_ids(external_ids)

        filtered_batch_data = batch_data.reject { |data| existing_ids.include?(data[:external_id]) }

        features_repository.insert_all(filtered_batch_data) unless filtered_batch_data.empty?
      end

      def build_batch_data(batch_features)
        batch_data = []

        batch_features.each do |feature|
          properties = feature['properties']
          geometry = feature['geometry']
          id = feature['id']

          next unless valid_data?(properties, geometry)

          batch_data << build_feature_data(id, properties, geometry)
        end

        batch_data
      end

      def build_feature_data(id, properties, geometry)
        {
          title: properties['title'], url: properties['url'],
          place: properties['place'], mag_type: properties['magType'],
          longitude: geometry['coordinates'][0], latitude: geometry['coordinates'][1],
          magnitude: properties['mag'], time: Time.at(properties['time'] / 1000),
          external_id: id, tsunami: properties['tsunami']
        }
      end

      def valid_data?(properties, geometry)
        required_fields_present?(properties) &&
          coordinates_present?(geometry) &&
          valid_magnitude?(properties['mag']) &&
          valid_latitude?(geometry['coordinates'][1]) &&
          valid_longitude?(geometry['coordinates'][0])
      end

      def required_fields_present?(properties)
        properties['title'].present? &&
          properties['url'].present? &&
          properties['place'].present? &&
          properties['magType'].present?
      end

      def coordinates_present?(geometry)
        geometry['coordinates'].present? &&
          geometry['coordinates'].size == 3
      end

      def valid_magnitude?(magnitude)
        magnitude.between?(-1.0, 10.0)
      end

      def valid_latitude?(latitude)
        latitude.between?(-90.0, 90.0)
      end

      def valid_longitude?(longitude)
        longitude.between?(-180.0, 180.0)
      end

      def feature_exists?(data)
        features_repository.exists?(data)
      end

      def initialize(
        repositories = {
          features_repository: Features::Repositories::FeaturesRepository
        }
      )
        @features_repository = repositories[:features_repository]
      end

      attr_reader :features_repository
    end
  end
end
