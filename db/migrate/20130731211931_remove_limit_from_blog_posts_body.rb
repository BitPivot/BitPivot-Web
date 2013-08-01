class RemoveLimitFromBlogPostsBody < ActiveRecord::Migration
  def self.up    
    change_column :blog_posts, :body, :text, limit: nil
  end

  def self.down
    change_column :blog_posts, :body, :string, limit: 255
  end
end
