# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Blogs
    describe DestroyBlog do
      describe "call" do
        let(:feature) { create(:feature, manifest_name: "blogs") }
        let!(:blog) { create(:blog, feature: feature) }
        let(:command) { described_class.new(feature) }

        it "broadcasts ok" do
          expect { command.call }.to broadcast(:ok)
        end

        it "deletes the blog associated to the feature" do
          expect do
            command.call
          end.to change { Blog.count }.by(-1)
        end
      end
    end
  end
end
