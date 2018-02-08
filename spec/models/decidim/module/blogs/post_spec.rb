# frozen_string_literal: true

require "spec_helper"

module Decidim::Module::Blogs
  describe Post do
    subject { post }

    let(:current_organization) { create(:organization) }
    let(:current_user) { create(:user, :confirmed, organization: current_organization) }
    let(:participatory_process) { create :participatory_process, organization: current_organization }
    let(:current_feature) { create :feature, participatory_space: participatory_process, manifest_name: "blogs" }
    let(:post) { create(:post, feature: current_feature, author: current_user) }

    include_examples "has feature"

    it { is_expected.to be_valid }

    context "without a feature" do
      let(:post) { build :post, feature: nil, author: current_user }

      it { is_expected.not_to be_valid }
    end

    context "without a valid feature" do
      let(:post) { build :post, feature: build(:feature, manifest_name: "proposals"), author: current_user }

      it { is_expected.not_to be_valid }
    end

    context "without a valid author" do
      let(:other_author) { create(:user) }
      let(:post) { build :post, feature: current_feature, author: other_author }

      it { is_expected.not_to be_valid }
    end

    it "has an associated feature" do
      expect(post.feature).to be_a(Decidim::Feature)
    end
  end
end
