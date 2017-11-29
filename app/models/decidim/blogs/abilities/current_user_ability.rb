# frozen_string_literal: true

module Decidim
  module Blogs
    module Abilities
      # Defines the abilities related to meetings for a logged in user.
      # Intended to be used with `cancancan`.
      class CurrentUserAbility
        include CanCan::Ability

        attr_reader :user, :context

        def initialize(user, context)
          return unless user

          @user = user
          @context = context

        end

        private

        def authorized?(action)
          return unless feature

          ActionAuthorizer.new(user, feature, action).authorize.ok?
        end

        def feature
          feature = context.fetch(:current_feature, nil)
          return nil unless feature && feature.manifest.name == :blogs

          feature
        end
      end
    end
  end
end
