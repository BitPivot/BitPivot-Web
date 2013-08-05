class ChangeResponseToColumnToRespondToId < ActiveRecord::Migration
  def self.up
    remove_column :blog_post_comments, :response_to, :integer, null: true
    add_column :blog_post_comments, :respond_to_id, :integer, null: true
  end

  def self.down
    remove_column :blog_post_comments, :respond_to_id, :integer, null: true
    add_column :blog_post_comments, :response_to, :integer, null: true
  end
end
