# frozen_string_literal: true

module Decidim
  module Blogs
    # Command that gets called when the blog of this feature needs to be
    # destroyed. It usually happens as a callback when the feature is removed.
    class DestroyBlog < Rectify::Command
      def initialize(feature)
        @feature = feature
      end

      def call
        Blog.where(feature: @feature).destroy_all
        broadcast(:ok)
      end
    end
  end
end
