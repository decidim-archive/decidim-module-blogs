# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      # This controller allows the create or update a blog.
      class BlogsController < Admin::ApplicationController

        def new
          @form = form(BlogForm).instance
        end

        def create
          @form = form(BlogForm).from_params(params, current_feature: current_feature)

          CreateBlog.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("blogs.create.success", scope: "decidim.blogs.admin")
              redirect_to blogs_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("blogs.create.invalid", scope: "decidim.blogs.admin")
              render action: "new"
            end
          end
        end

        def edit
          @form = form(BlogForm).from_model(blog)
        end

        def update
          @form = form(BlogForm).from_params(params, current_feature: current_feature)

          UpdateBlog.call(@form, blog) do
            on(:ok) do
              flash[:notice] = I18n.t("blogs.update.success", scope: "decidim.blogs.admin")
              redirect_to blogs_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("blogs.update.invalid", scope: "decidim.blogs.admin")
              render action: "edit"
            end
          end
        end

        def destroy
          blog.destroy!

          flash[:notice] = I18n.t("blogs.destroy.success", scope: "decidim.blogs.admin")

          redirect_to blogs_path
        end

        private

        def blog
          @blog ||= Blogs::Blog.find_by(feature: current_feature)
        end
      end
    end
  end
end
