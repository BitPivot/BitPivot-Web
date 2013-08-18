class BlogPost < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper

  attr_accessible :id, :file_name, :title, :subtitle, :author, :year, :month, :day,
                  :categories, :body, :md5_hash, :banner_image

  has_many :blog_post_comments

  def post_url
    "/blog/posts/#{self.id}-#{self.file_name.slice(0..(self.file_name.index('.')-1))}"
  end

  def author_url
    "/blog/authors/#{self.author.split(' ')[0]}".downcase
  end

  def formatted_date
    year_link = "/blog/#{self.year}"
    month_link = "#{year_link}/#{self.month}"
    day_link = "#{month_link}/#{self.day}"
    date = " #{link_to Date::MONTHNAMES[self.month], month_link} "
    date << "#{link_to self.day, day_link}, "
    date << "#{link_to self.year, year_link}"
  end

  def top_level_comments
    self.approved_comments.where(:respond_to_id => nil)
  end

  def approved_comments
    self.blog_post_comments.where(approved: true)
  end

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
      #{self.body}\
      #{self.banner_image}"
    )
  end
end
