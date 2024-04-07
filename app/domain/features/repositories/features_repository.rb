module Features
  module Repositories
    # This class represents a repository for performing write operations on the Feature model.
    #
    # It extends the ArCommandsRepository class and provides specific commands for
    # interacting with the Feature model using Active Record.
    class FeaturesRepository < Common::Repositories::ArCommandsRepository
      class << self
        delegate :insert_all, to: :new
        delegate :existing_external_ids, to: :new
      end

      def insert_all(data)
        model.insert_all(data)
      end

      def existing_external_ids(external_ids)
        model.where(external_id: external_ids).pluck(:external_id)
      end

      def initialize(model = Feature)
        super(model)
      end
    end
  end
end
