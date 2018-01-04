# frozen_string_literal: true

require "spec_helper"

module Decidim::Module::Blogs
  describe Post do
    subject { post }

    let(:post) { create(:post) }

    include_examples "has feature"

    it { is_expected.to be_valid }

    context "without a feature" do
      let(:post) { build :post, feature: nil }

      it { is_expected.not_to be_valid }
    end

    context "without a valid feature" do
      let(:post) { build :post, feature: build(:feature, manifest_name: "blogs") }

      it { is_expected.not_to be_valid }
    end

    it "has an associated feature" do
      expect(post.feature).to be_a(Decidim::Feature)
    end
  end
end
