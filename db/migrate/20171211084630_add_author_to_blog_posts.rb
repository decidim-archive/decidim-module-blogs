class AddAuthorToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_blogs_posts, :decidim_author_id, :integer, index: true
  end
end
