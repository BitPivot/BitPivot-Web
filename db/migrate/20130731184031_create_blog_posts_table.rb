class CreateBlogPostsTable < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.string :category
      t.integer :year
      t.integer :month
      t.integer :day

      t.timestamps
    end
  end
end
