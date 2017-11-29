# frozen_string_literal: true

module Decidim
  module Blogs
    # Custom helpers used in meetings views
    module BlogsHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper

      # Public: truncates the meeting description
      #
      # meeting - a Decidim::Meeting instance
      # max_length - a number to limit the length of the description
      #
      # Returns the meeting's description truncated.
      def blog_description(blog, max_length = 120)
        link = resource_locator(blog).path
        body = translated_attribute(blog.body)
        tail = "... #{link_to(t("read_more", scope: "decidim.blogs"), link)}".html_safe
        CGI.unescapeHTML html_truncate(body, max_length: max_length, tail: tail)
      end
    end
  end
end
