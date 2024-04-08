module Comments
  module Repositories
    class CommentsRepository < Common::Repositories::ArCommandsRepository
      def initialize(model = Comment)
        super(model)
      end
    end
  end
end
