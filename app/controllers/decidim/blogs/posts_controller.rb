# frozen_string_literal: true

module Decidim
  module Blogs
    # Exposes the blog resource so users can view them
    class PostsController < Decidim::Blogs::ApplicationController
      helper_method :posts, :post, :paginate_posts, :posts_most_commented

      def index; end

      def show; end

      private

      def paginate_posts
        @paginate_posts ||= posts.created_at_desc.page(params[:page]).per(4)
      end

      def post
        @post ||= posts.find(params[:id])
      end

      def posts
        @posts ||= Post.where(feature: current_feature)
      end

      def posts_most_commented
        # @posts_most_commented ||= posts.includes(:comments).order("comments.size ASC")
      end
    end
  end
end
