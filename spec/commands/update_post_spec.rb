# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Blogs
    module Admin
      describe UpdatePost do
        let(:current_organization) { create(:organization) }
        let(:participatory_process) { create(:participatory_process, organization: current_organization) }
        let(:feature) { create(:feature, manifest_name: "posts", participatory_space: participatory_process) }
        let(:post) { create(:post, feature: feature) }
        let(:form_params) do
          {
            "title" => post.title,
            "body" => post.body,
            "page" => {
              "commentable" => false
            }
          }
        end
        let(:form) do
          PostForm.from_params(
            form_params
          ).with_context(
            current_organization: current_organization
          )
        end
        let(:command) { described_class.new(form, post) }

        describe "when the form is invalid" do
          before do
            expect(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the post" do
            expect(post).not_to receive(:update_attributes!)
            command.call
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new post with the same name as the feature" do
            expect(post).to receive(:update_attributes!)
            command.call
          end
        end
      end
    end
  end
end
