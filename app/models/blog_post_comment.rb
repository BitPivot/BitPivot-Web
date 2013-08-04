class BlogPostComment < ActiveRecord::Base
  attr_accessible :author, :email, :votes, :content, :response_to

  belongs_to :blog_post
  has_one :blog_post_comment, :foreign_key => 'response_to'
end
