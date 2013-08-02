class BlogPost < ActiveRecord::Base
  attr_accessible :file_name, :title, :subtitle, :author, :year, :month, :day, :categories, :body, :md5_hash, :blog_post_comment

  has_many :blog_post_comments

  def md5
    require 'digest/md5'
    Digest::MD5.hexdigest("
      #{self.file_name}\
      #{self.title}\
      #{self.subtitle}\
      #{self.author}\
      #{self.year}\
      #{self.month}\
      #{self.day}\
      #{self.categories}\
      #{self.body}"
    )
  end
end
