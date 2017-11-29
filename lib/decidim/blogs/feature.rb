# frozen_string_literal: true

require "decidim/features/namer"

Decidim.register_feature(:blogs) do |feature|
  feature.engine = Decidim::Blogs::Engine
  feature.admin_engine = Decidim::Blogs::AdminEngine
  feature.icon = "decidim/blogs/icon.svg"

  feature.on(:before_destroy) do |instance|
    raise StandardError, "Can't remove this feature" if Decidim::Blogs::Blog.where(feature: instance).any?
  end

  feature.register_stat :blogs_count, primary: true, priority: Decidim::StatsRegistry::MEDIUM_PRIORITY do |features|
    Decidim::Blogs::Blog.where(feature: features).count
  end

  feature.actions = %w(join)

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

  feature.seeds do |participatory_space|
    feature = Decidim::Feature.create!(
      name: Decidim::Features::Namer.new(participatory_space.organization.available_locales, :blogs).i18n_name,
      manifest_name: :blogs,
      published_at: Time.current,
      participatory_space: participatory_space
    )

    Decidim::Blogs::Blog.create!(
      feature: feature,
      body: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(3)
      end
    )
  end
end
