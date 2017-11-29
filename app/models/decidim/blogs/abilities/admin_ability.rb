# frozen_string_literal: true

module Decidim
  module Blogs
    module Abilities
      # Defines the abilities related to proposals for a logged in admin user.
      # Intended to be used with `cancancan`.
      class AdminAbility < Decidim::Abilities::AdminAbility
        def define_abilities
          super

          can :manage, Blog
        end

      end
    end
  end
end
