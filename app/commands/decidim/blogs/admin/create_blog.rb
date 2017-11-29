# frozen_string_literal: true

module Decidim
  module Blogs
    # Command that gets called whenever a feature's blog has to be created. It
    # usually happens as a callback when the feature itself is created.
    class Createblog < Rectify::Command
      def initialize(feature)
        @feature = feature
      end

      def call
        @blog = Blog.new(feature: @feature)

        @blog.save ? broadcast(:ok) : broadcast(:invalid)
      end
    end
  end
end


# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      # This command is executed when the user creates a Meeting from the admin
      # panel.
      class CreateBlog < Rectify::Command
        def initialize(form)
          @form = form
        end

        # Creates the meeting if valid.
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
