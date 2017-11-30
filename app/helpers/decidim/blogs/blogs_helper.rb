# frozen_string_literal: true

module Decidim
  module Blogs
    # Custom helpers used in blogs views
    module BlogsHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper

      # Public: truncates the blog body
      #
      # blog - a Decidim::Blog instance
      # max_length - a number to limit the length of the body
      #
      # Returns the blog's body truncated.
      def blog_description(blog, max_length = 120)
        link = resource_locator(blog).path
        body = translated_attribute(blog.body)
        tail = "... #{link_to(t("read_more", scope: "decidim.blogs"), link)}".html_safe
        CGI.unescapeHTML html_truncate(body, max_length: max_length, tail: tail)
      end
    end
  end
end
