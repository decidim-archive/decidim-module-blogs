# frozen_string_literal: true

module Decidim
  module Blogs
    # Exposes the blog resource so users can view them
    class PostsController < Decidim::Blogs::ApplicationController
      helper_method :posts, :post

      def index; end

      def show; end

      private

      def post
        @post ||= posts.find(params[:id])
      end

      def posts
        @posts ||= Post.where(feature: current_feature).page(params[:page]).per(9)
      end
    end
  end
end
