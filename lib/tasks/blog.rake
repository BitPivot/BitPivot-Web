require 'ostruct'
require "#{Rails.root}/app/helpers/blog_helper"

namespace :blog do

  task :compile => :environment do
    include BlogHelper

    puts "Compiling blog posts...\n"

    posts_dir = 'blog/live/'
    post_paths = Dir["#{posts_dir}*.erb"]
    code_block_regex = /<pre>\s*<code\s+class=(?:"|')(.*?)(?:"|')\s*>([\S\s]*?)<\/code>\s*<\/pre>/

    current_file_names = []
    changes = { created: [], updated: [], deleted: [] }

    post_paths.each do |path|      
      post = BlogHelper::compile(path,code_block_regex)

      current_file_names << post.file_name

      unless BlogPost.exists?(file_name: post.file_name)
        post.save
        changes[:created] << post.file_name
        next
      end

      existing = BlogPost.find_by(file_name: post.file_name)

      next if existing.md5_hash == post.md5_hash
      existing.update_attributes(post.attributes)
      existing.save
      changes[:updated] << existing.file_name
      end
    end


    # Remove deleted drafts from DB
    existing = BlogPost.all.to_a
    existing.each do |existing_post|
      next if current_file_names.include?(existing_post.file_name)
      existing_post.delete
      changes[:deleted] << existing_post.file_name
    end


    # Print changes to terminal
    changes.each do |action, file_names|
      next if file_names.length == 0
      file_names.each do |f|
        puts "#{action}:\t#{f}"
      end
    end

    puts 'Done!'
  end
end