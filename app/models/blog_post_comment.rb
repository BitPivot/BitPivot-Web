class BlogPostComment < ActiveRecord::Base
  attr_accessible :author, :email, :votes, :content, :respond_to_id

  belongs_to :blog_post

  belongs_to :blog_post_comments
  has_many :blog_post_comments, :foreign_key => 'respond_to_id'
end
