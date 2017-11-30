# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      # This command is executed when the user creates a Blog from the admin
      # panel.
      class CreateBlog < Rectify::Command
        def initialize(form)
          @form = form
        end

        # Creates the blog if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          transaction do
            create_blog!
          end

          broadcast(:ok, @blog)
        end

        private

        def create_blog!
          @blog = Blog.create!(
            title: @form.title,
            body: @form.body,
            feature: @form.current_feature
          )
        end
      end
    end
  end
end
