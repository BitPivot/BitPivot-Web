class CreateBlogPostComments < ActiveRecord::Migration
  def change
    create_table :blog_post_comments do |t|
      t.belongs_to :blog_post
      t.integer :votes, null: true
      t.string :author, null: false
      t.text :content, limit: nil
      t.timestamps
    end

    change_table :blog_posts do |t|
      t.references :blog_post_comments, index: true
    end
  end
end
