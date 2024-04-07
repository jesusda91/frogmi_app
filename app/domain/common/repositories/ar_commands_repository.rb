module Common
  module Repositories
    # This class represents a repository for executing Active Record commands.
    #
    # It provides a common interface for performing write operations on the database
    # using Active Record. Subclasses should implement specific commands for
    # interacting with the database.
    class ArCommandsRepository
      def create(data)
        raise NotImplementedError, 'Subclasses must implement this method'
      end

      def initialize(model = nil)
        @model = model
      end

      attr_reader :model
    end
  end
end