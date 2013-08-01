class AddHashToBlogPost < ActiveRecord::Migration
   def self.up
    add_column :blog_posts, :hash, :string, null: false
  end

  def self.down
    remove_column :blog_posts, :hash, :string, null: false
  end
end
