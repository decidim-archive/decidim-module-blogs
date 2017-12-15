# frozen_string_literal: true

module Decidim
  module Blogs
    # Exposes the blog resource so users can view them
    class PostsController < Decidim::Blogs::ApplicationController
      helper_method :posts, :post, :paginate_posts

      def index; end

      def show; end

      private

      def paginate_posts
        @paginate_posts ||= posts.page(params[:page]).per(4)
      end

      def post
        @post ||= posts.find(params[:id])
      end

      def posts
        @posts ||= Post.where(feature: current_feature)
      end
    end
  end
end
