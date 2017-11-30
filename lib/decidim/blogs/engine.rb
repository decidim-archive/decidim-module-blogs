# frozen_string_literal: true

require "kaminari"
require "jquery-tmpl-rails"

module Decidim
  module Blogs
    # This is the engine that runs on the public interface of `decidim-module-blogs`.
    # It mostly handles rendering the created blogs associated to a participatory
    # process.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Blogs

      routes do
        resources :blogs, only: [:index, :show]
        root to: "blogs#index"
      end
    end
  end
end
