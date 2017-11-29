# frozen_string_literal: true

module Decidim
  module Blogs
    # The data store for a Blog in the Decidim::Blogs component. It stores a
    # title, description and any other useful information to render a blog.
    class Blog < Blogs::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::HasFeature

      feature_manifest_name "blogs"

    end
  end
end
