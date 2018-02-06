# frozen_string_literal: true

module Decidim
  module Module
    module Blogs
    #
    # Decorator for posts
    #
      class PostPresenter < SimpleDelegator
        def author
          @author ||= if official?
                        Decidim::Module::Blogs::OfficialAuthorPresenter.new
                      else
                        Decidim::UserPresenter.new(super)
                      end
        end
      end
    end
  end
end
