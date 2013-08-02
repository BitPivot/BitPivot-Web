class BlogPostComment < ActiveRecord::Base
  attr_accessible :author, :email, :votes, :content

  belongs_to :blog_post
end
