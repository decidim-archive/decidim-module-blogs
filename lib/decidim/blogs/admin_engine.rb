# frozen_string_literal: true

module Decidim
  module Blogs
    # This is the admin interface for `decidim-module-blogs`. It lets you edit and
    # configure the blog associated to a participatory process.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Blogs::Admin

      paths["db/migrate"] = nil

      routes do
        resources :blogs
        root to: "blogs#index"
      end

      def load_seed
        nil
      end
    end
  end
end
