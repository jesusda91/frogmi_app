module Comments
  module Repositories
    class CommentsRepository < Common::Repositories::ArCommandsRepository
      def create(data)
        model.create(data)
      end

      def initialize(model = Comment)
        super(model)
      end
    end
  end
end
