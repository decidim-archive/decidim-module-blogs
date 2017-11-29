# frozen_string_literal: true

require "kaminari"

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

      initializer "decidim_blogs.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.abilities += ["Decidim::Blogs::Abilities::CurrentUserAbility"]
        end
      end

    end
  end
end
