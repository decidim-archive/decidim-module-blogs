# frozen_string_literal: true

require "spec_helper"

describe "Show a blog", type: :feature do
  include_context "with a feature"
  let(:manifest_name) { "blogs" }

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

  let!(:blog_feature) { create(:blog, feature: feature, title: title, body: body) }

  describe "blog show" do
    before do
      visit_feature
    end

    it "renders the content of the blog" do
      expect(blog).to have_content("Content")
    end
  end
end
