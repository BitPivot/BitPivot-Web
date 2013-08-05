class AddResponseToColumnToComments < ActiveRecord::Migration
  def self.up
    add_column :blog_post_comments, :response_to, :integer, null: true
  end

  def self.down
    remove_column :blog_post_comments, :response_to, :integer, null: true
  end
end
