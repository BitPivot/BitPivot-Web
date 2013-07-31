class AddBodyToBlogPosts < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :body, :string, null: false
  end

  def self.down
    remove_column :blog_posts, :body, :string, null: false
  end
end
