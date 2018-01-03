# frozen_string_literal: true

require "spec_helper"

describe "Edit a post", type: :feature do
  include_context "when managing a feature as an admin"
  let(:feature) { create(:feature, manifest_name: "blogs", participatory_space: participatory_process) }
  let(:manifest_name) { "blogs" }

  describe "admin post" do
    before do
      create(:post, feature: feature, title: title, body: body)
      visit_feature_admin
    end

    let(:title) do
      {
        "en" => "Title",
        "ca" => "Títol",
        "es" => "Título"
      }
    end

    let(:body) do
      {
        "en" => "<p>Content</p>",
        "ca" => "<p>Contingut</p>",
        "es" => "<p>Contenido</p>"
      }
    end

    it "updates the post" do
      new_body = {
        en: "<p>New body</p>",
        ca: "<p>Nou cos</p>",
        es: "<p>Nuevo cuerpo</p>"
      }

      within "form.edit_post" do
        fill_in_i18n_editor(:post_body, "#post-body-tabs", new_body)
        find("*[type=submit]").click
      end

      expect(post).to have_admin_callout("successfully")

      visit_feature

      expect(post).to have_content("New body")
    end
  end

  describe "announcements" do
    before do
      create(:post, feature: feature, title: title, body: body)
      visit_feature_admin
    end
    it_behaves_like "manage announcements"
  end
end
