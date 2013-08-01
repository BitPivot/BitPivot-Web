class BlogPost < ActiveRecord::Base
  attr_accessible :title, :subtitle, :author, :year, :month, :day, :categories, :body
end
