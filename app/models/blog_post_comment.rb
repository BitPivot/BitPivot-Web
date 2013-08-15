require 'cgi'

class BlogPostComment < ActiveRecord::Base
  attr_accessible :author, :email, :votes, :content, :approved, :respond_to_id

  belongs_to :blog_post
  belongs_to :blog_post_comments
  has_many :blog_post_comments, :foreign_key => 'respond_to_id'

  before_save { self.email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :author, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :content, presence: true
  

  def approval_url
    "/admin/blog/approve_comment/#{self.id}"
  end

  def deletion_url
    "/admin/blog/delete_comment/#{self.id}"
  end

  def formatted_date
    self.created_at.to_formatted_s(:long_ordinal)
  end

  def is_admin_comment
    return self.email =~ /.*\@bitpivot\.com/
  end

  def respond_to_comment_url(post_id)
    "/blog/respond_to_comment/#{post_id}/#{self.id}#respond"
  end

  def to_email
    email = "Author:\t#{self.author}\n"
    email << "Email:\t#{self.email}\n"
    email << "Date:\t#{self.formatted_date}\n\n"
    email << "#{CGI.unescapeHTML(self.content)}"
  end
end
