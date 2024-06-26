module Common
  module Repositories
    # This class represents a repository for executing Active Record commands.
    #
    # It provides a common interface for performing write operations on the database
    # using Active Record. Subclasses should implement specific commands for
    # interacting with the database.
    class ArCommandsRepository
      class << self
        delegate :insert_all, to: :new
        delegate :count, to: :new
        delegate :create, to: :new
        delegate :find, to: :new
      end

      def insert_all(data)
        raise NotImplementedError, 'Subclasses must implement this method'
      end

      def create(data)
        model.create(data)
      end

      def find(param)
        model.find(param)
      end

      def count
        model.count
      end

      def initialize(model = nil)
        @model = model
      end

      attr_reader :model
    end
  end
end