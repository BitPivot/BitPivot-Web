class RenameBlogPostsTable < ActiveRecord::Migration
  def self.up
    rename_table :blog_posts_tables, :blog_posts
  end

  def self.down
    rename_table :blog_posts, :blog_posts_tables
  end
end
