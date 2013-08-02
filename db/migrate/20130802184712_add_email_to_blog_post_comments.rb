class AddEmailToBlogPostComments < ActiveRecord::Migration
  def self.up
    add_column :blog_post_comments, :email, :string, null: false
  end

  def self.down
    remove_column :blog_posts_comments, :email, :string, null: false
  end
end
