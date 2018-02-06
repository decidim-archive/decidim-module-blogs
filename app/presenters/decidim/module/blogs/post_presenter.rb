# frozen_string_literal: true

module Decidim
  module Module
    module Blogs
    #
    # Decorator for posts
    #
      class PostPresenter < SimpleDelegator
        def author
          @author ||=  Decidim::UserPresenter.new(super)
        end
      end
    end
  end
end
