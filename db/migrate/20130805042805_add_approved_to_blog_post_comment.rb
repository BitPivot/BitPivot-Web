class AddApprovedToBlogPostComment < ActiveRecord::Migration
  def self.up
    add_column :blog_post_comments, :approved, :boolean, default: false
  end

  def self.down
    remove_column :blog_post_comments, :approved, :boolean, default: false
  end
end
