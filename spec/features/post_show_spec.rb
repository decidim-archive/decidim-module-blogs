# frozen_string_literal: true

require "spec_helper"

describe "Show a post", type: :feature do
  include_context "with a feature"
  let(:manifest_name) { "posts" }

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

  let!(:post_feature) { create(:post, feature: feature, title: title, body: body) }

  describe "post show" do
    before do
      visit_feature
    end

    it "renders the content of the post" do
      expect(post).to have_content("Content")
    end
  end
end
