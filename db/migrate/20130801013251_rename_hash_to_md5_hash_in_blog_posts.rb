class RenameHashToMd5HashInBlogPosts < ActiveRecord::Migration
  def self.up
    rename_column  :blog_posts, :hash, :md5_hash
  end

  def self.down
    rename_column  :blog_posts, :md5_hash, :hash
  end
end
