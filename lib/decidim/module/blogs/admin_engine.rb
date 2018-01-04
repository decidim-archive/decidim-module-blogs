# frozen_string_literal: true

module Decidim
  module Module
    module Blogs
      # This is the admin interface for `decidim-module-blogs`. It lets you edit and
      # configure the blog associated to a participatory process.
      class AdminEngine < ::Rails::Engine
        isolate_namespace Decidim::Module::Blogs::Admin

        paths["db/migrate"] = nil

        routes do
          resources :posts
          root to: "posts#index"
        end

        initializer "decidim_module_blogs_admin.inject_abilities_to_user" do |_app|
          Decidim.configure do |config|
            config.admin_abilities += [
              "Decidim::Module::Blogs::Abilities::Admin::AdminAbility"
            ]
          end
        end

        def load_seed
          nil
        end
      end
    end
  end
end
