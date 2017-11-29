# frozen_string_literal: true

class CreateDecidimBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_blogs_blogs do |t|
      t.jsonb :title
      t.jsonb :body
      t.references :decidim_feature, index: true
      t.boolean :commentable, null: false, default: false
      
      t.timestamps
    end
  end
end
