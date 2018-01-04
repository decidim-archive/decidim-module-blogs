# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Module
    module Blogs
      module Admin
        describe CreatePost do
          subject { described_class.new(form) }

          let(:organization) { create :organization }
          let(:participatory_process) { create :participatory_process, organization: organization }
          let(:current_feature) { create :feature, participatory_space: participatory_process, manifest_name: "blogs" }
          let(:current_user) { create :user, organization: organization }
          let(:name) { "Planned" }
          let(:body) { "description" }

          let(:invalid) { false }
          let(:form) do
            double(
              invalid?: invalid,
              title: { en: name },
              body: { en: body },
              current_feature: current_feature.id,
              decidim_author_id: current_user.id
            )
          end

          context "when the form is not valid" do
            let(:invalid) { true }

            it "is not valid" do
              expect { subject.call }.to broadcast(:invalid)
            end
          end

          context "when everything is ok" do
            let(:post) { Post.last }

            it "creates the post" do
              expect { subject.call }.to change { Post.count }.by(1)
            end

            # it "sets the title" do
            #   subject.call
            #   expect(translated(post.title)).to eq title
            # end
            #
            # it "sets the body" do
            #   subject.call
            #   expect(translated(post.body)).to eq body
            # end
            #
            it "sets the author" do
              subject.call
              expect(post.author).to eq current_userd
            end
            #
            # it "sets the feature" do
            #   subject.call
            #   expect(post.current_feature).to eq current_feature.id
            # end

          end

          # describe "call" do
          #   let(:feature) { create(:feature, manifest_name: "blogs") }
          #   let(:command) { described_class.new(feature) }
          #
          #   describe "when the post is not saved" do
          #     before do
          #       expect_any_instance_of(Post).to receive(:save).and_return(false)
          #     end
          #
          #     it "broadcasts invalid" do
          #       expect { command.call }.to broadcast(:invalid)
          #     end
          #
          #     it "doesn't create a post" do
          #       expect do
          #         command.call
          #       end.not_to change { Post.count }
          #     end
          #   end
          #
          #   describe "when the post is saved" do
          #     it "broadcasts ok" do
          #       expect { command.call }.to broadcast(:ok)
          #     end
          #
          #     it "creates a new post with the same name as the feature" do
          #       expect(Post).to receive(:new).with(feature: feature).and_call_original
          #
          #       expect do
          #         command.call
          #       end.to change { Post.count }.by(1)
          #     end
          #   end
          # end
        end
      end
    end
  end
end
