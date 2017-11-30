# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      # This command is executed when the user changes a Blog from the admin
      # panel.
      class UpdateBlog < Rectify::Command
        # Initializes a UpdateBlog Command.
        #
        # form - The form from which to get the data.
        # blog - The current instance of the page to be updated.
        def initialize(form, blog)
          @form = form
          @blog = blog
        end

        # Updates the blog if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            update_blog!
          end

          broadcast(:ok, blog)
        end

        private

        attr_reader :form, :blog

        def update_blog!
          blog.update_attributes!(
            title: form.title,
            body: form.body
          )
        end
      end
    end
  end
end
