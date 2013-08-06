class MakeCommentBlogPostIdNonNull < ActiveRecord::Migration
  def up
    change_column :blog_post_comments, :blog_post_id, :integer, null: false
  end

  def down
    change_column :blog_post_comments, :blog_post_id, :integer, null: true
  end
end
