class RenameCategoryInBlogPosts < ActiveRecord::Migration
  def self.up
    rename_column  :blog_posts, :category, :categories
  end

  def self.down
    rename_column  :blog_posts, :categories, :category
  end
end
