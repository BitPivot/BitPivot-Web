require 'ostruct'

namespace :blog do

  task :compile => :environment do
    include ERB::Util

    puts "\nCompiling blog posts...\n"

    posts_input_path = 'app/views/blog/posts/'

    # Keep track of changes as filesnames for terminal output
    current_file_names = []
    changes = {
        created: [],
        updated: [],
        deleted: []
    }

    # Get all blog post paths
    post_paths = Dir["#{posts_input_path}*.erb"]
    puts "\nFound #{post_paths.length} blog posts in input directory'#{posts_input_path}'"

    # Create / update posts in DB from input file paths
    post_paths.each do |path|

      # Get all contents of post file
      contents = File.read(path)

      # YAML variables to hash
      locals = YAML.load(contents)

      # Initialize new post from Model
      post = BlogPost.new(locals)

      # Slice file name from path
      start = path.rindex('/')+1
      stop = path.length-1
      post.file_name = path.slice(start..stop)
      current_file_names << post.file_name

      # Post contents without YAML header for ERB
      contents_no_yaml = contents.gsub(/---(.|\n)*?---/, '')

      # Compile ERB into post body 
      post.body = html_escape(ERB.new(contents_no_yaml).result(post.instance_eval { binding }))

      # Categories was an array of strings for easy looping when ERB parsed it above
      # Join into comma delimited string for storage in DB.
      post.categories = post.categories.join(',')

      # Set hash on post for update checking
      post.md5_hash = post.md5()

      # Post exists
      if BlogPost.exists?(file_name: post.file_name)
        existing = BlogPost.find_by(file_name: post.file_name)

        # Post is different
        if existing.md5_hash != post.md5_hash

          # Update post
          existing.update_attributes(post.attributes)
          existing.save
          changes[:updated] << existing.file_name
        end
      else
        # Create post
        post.save
        changes[:created] << post.file_name
      end
    end



    # Remove deleted posts from DB
    existing = BlogPost.all.to_a
    existing.each do |existing_post|
      # Blog post was deleted from input directory
      unless current_file_names.include?(existing_post.file_name)
        existing_post.delete
        changes[:deleted] << existing_post.file_name
      end
    end



    # Print changes to terminal
    changes.each do |action,file_names|
      if file_names.length > 0
        puts "\nPosts #{action}:\n\n"
        file_names.each do |f|
          puts "\t#{f}"
        end
      end
    end

    puts "\nSuccess!"
  end
end