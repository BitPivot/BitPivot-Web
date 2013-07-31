require 'ostruct'

namespace :blog do

	task :compile => :environment do
    include ERB::Util

    # Clear blog posts
    BlogPost.delete_all

    # Get all blog post paths
  	posts = Dir['app/views/blog/posts/*.erb']
    puts "Parsing #{posts.length} blog posts into 'blog_posts' table..."

  	posts.each do |path|

      # Get all contents of post file
  		contents = File.read(path)

      # YAML variables to hash
  		locals = YAML.load(contents)

      # Initialize new post from Model
      post = BlogPost.new(locals)

      # Post contents without YAML header for ERB
      contents_no_yaml = contents.gsub(/---(.|\n)*?---/,'')

      # Compile ERB into post body 
      post.body = html_escape(ERB.new(contents_no_yaml).result(post.instance_eval { binding }))

      # Categories was an array of strings for easy looping when ERB parsed it above
      # Join into comma delimited string for storage in DB.
      post.categories = post.categories.join(',')

      post.save
  	end

    puts "Success!"
	end
end