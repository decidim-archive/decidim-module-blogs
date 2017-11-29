# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      # This class holds a Form to update pages from Decidim's admin panel.
      class BlogForm < Decidim::Form
        include TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :body, String
      end
    end
  end
end
