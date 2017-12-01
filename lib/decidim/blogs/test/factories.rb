# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/participatory_processes/test/factories"

FactoryBot.define do
  factory :post_feature, parent: :feature do
    name { Decidim::Features::Namer.new(participatory_space.organization.available_locales, :posts).i18n_name }
    manifest_name :posts
    participatory_space { create(:participatory_process, :with_steps, organization: organization) }
  end

  factory :post, class: "Decidim::Blogs::Post" do
    title { Decidim::Faker::Localized.sentence(3) }
    body { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    feature { build(:feature, manifest_name: "posts") }
  end
end
