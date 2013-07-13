class BlogController < ApplicationController

  def show_post
    filename = "#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}.html.erb"

    puts "\nRequest Params:\n"
    params.each do |k,v|
      puts "\t#{k}: #{v}"
    end
    puts "\n"

    render "blog/posts/#{filename}"
  end

end
