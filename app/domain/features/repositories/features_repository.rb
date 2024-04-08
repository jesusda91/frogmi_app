module Features
  module Repositories
    # This class represents a repository for performing write operations on the Feature model.
    #
    # It extends the ArCommandsRepository class and provides specific commands for
    # interacting with the Feature model using Active Record.
    class FeaturesRepository < Common::Repositories::ArCommandsRepository
      class << self
        delegate :existing_external_ids, to: :new
        delegate :paginate, to: :new
      end

      def insert_all(data)
        model.insert_all(data)
      end

      def count
        model.count
      end

      def existing_external_ids(external_ids)
        model.where(external_id: external_ids).pluck(:external_id)
      end

      def paginate(filter_conditions, per_page, page)
        model.where(filter_conditions)
             .limit(per_page)
             .offset((page - 1) * per_page)
             .order(id: :asc)
      end

      def initialize(model = Feature)
        super(model)
      end
    end
  end
end
