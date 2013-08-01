class AddFileNameAttributeToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :file_name, :string, null: false
  end

  def self.down
    remove_column :blog_posts, :file_name, :string, null: false
  end
end
