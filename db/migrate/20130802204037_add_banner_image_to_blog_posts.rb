class AddBannerImageToBlogPosts < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :banner_image, :string
  end

  def self.down
    remove_column :blog_posts, :banner_image, :string
  end
end
