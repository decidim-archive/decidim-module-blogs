# frozen_string_literal: true

module Decidim
  module Blogs
    # Exposes the blog resource so users can view them
    class BlogsController < Decidim::Blogs::ApplicationController
      # include FilterResource
      # include Paginable

      helper_method :blogs, :blog

      def index; end

      def show; end

      private

      def blog
        @blog ||= blogs.find(params[:id])
      end

      def blogs
        @blogs ||= Blog.where(feature: current_feature)
      end
    end
  end
end
