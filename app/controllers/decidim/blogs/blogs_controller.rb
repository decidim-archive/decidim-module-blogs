# frozen_string_literal: true

module Decidim
  module Blogs
    # Exposes the meeting resource so users can view them
    class BlogsController < Decidim::Blogs::ApplicationController
      #include FilterResource
      # include Paginable

      helper_method :blogs, :blog

      def index

      end

      def show
        @blog = Blog.find_by(feature: current_feature)
      end

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
