# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Blogs
    describe CreateBlog do
      describe "call" do
        let(:feature) { create(:feature, manifest_name: "blogs") }
        let(:command) { described_class.new(feature) }

        describe "when the blog is not saved" do
          before do
            # rubocop:disable RSpec/AnyInstance
            expect_any_instance_of(Blog).to receive(:save).and_return(false)
            # rubocop:enable RSpec/AnyInstance
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't create a blog" do
            expect do
              command.call
            end.not_to change { Blog.count }
          end
        end

        describe "when the blog is saved" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new blog with the same name as the feature" do
            expect(Blog).to receive(:new).with(feature: feature).and_call_original

            expect do
              command.call
            end.to change { Blog.count }.by(1)
          end
        end
      end
    end
  end
end
