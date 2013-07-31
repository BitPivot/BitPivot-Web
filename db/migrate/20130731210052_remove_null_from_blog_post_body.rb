class RemoveNullFromBlogPostBody < ActiveRecord::Migration
  def self.up    
    change_column :blog_posts, :body, :string, null: true
  end

  def self.down
    change_column :blog_posts, :body, :string, null: false
  end
end
