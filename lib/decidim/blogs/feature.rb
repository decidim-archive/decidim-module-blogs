# frozen_string_literal: true

require "decidim/features/namer"

Decidim.register_feature(:blogs) do |feature|
  feature.engine = Decidim::Blogs::Engine
  feature.admin_engine = Decidim::Blogs::AdminEngine
  ## TODO Change the icon to a blog one.
  feature.icon = "decidim/blogs/icon.svg"

  feature.on(:before_destroy) do |instance|
    raise StandardError, "Can't remove this feature" if Decidim::Blogs::Blog.where(feature: instance).any?
  end

  feature.settings(:global) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :comments_enabled, type: :boolean, default: true
  end

  feature.settings(:step) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :comments_blocked, type: :boolean, default: false
  end

  feature.register_resource do |resource|
    resource.model_class_name = "Decidim::Blogs::Blog"
  end
end
