class BlogController < ApplicationController

  layout 'blog'

  def view
    @page_size = 5
    @page_posts = []
    @page = Integer(params[:page]) || 1
    @posts = Dir['app/views/blog/posts/*.erb']
    @posts.each_with_index do |p, i|
      if i >= (@page - 1) * @page_size && i < ((@page-1) * @page_size) + @page_size
        @page_posts.push("/#{p}")
      end
    end
  end

  def show
    render "blog/posts/#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}"
  end

end