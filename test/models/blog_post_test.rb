require 'digest/md5'
require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  def setup
    @test_post = BlogPost.new({
      id: 1,
      file_name: 'blog/live/TestFileName.html.erb',
      email: 'test@test.com',
      password: @test_password,
      password_confirmation: @test_password,
      role: 0
    })
  end

  test 'hashes correctly' do
    expected = Digest::MD5.hexdigest(
"#{@test_post.file_name}\
#{@test_post.title}\
#{@test_post.subtitle}\
#{@test_post.author}\
#{@test_post.year}\
#{@test_post.month}\
#{@test_post.day}\
#{@test_post.categories}\
#{@test_post.body}\
#{@test_post.banner_image}"
    )

    assert_equal expected, @test_post.md5, 'post not hashed correctly'
  end

  test 'post url formatted correctly' do
    expected = "/blog/posts/#{@test_post.id}-#{@test_post.file_name.slice(0..(@test_post.file_name.index('.')-1))}"

    assert_equal expected, @test_post.post_url, 'post url not formatted correctly'
  end

  test 'post author url formatted correctly' do
    expected = "/blog/authors/#{@test_post.author.split(' ')[0]}".downcase

    assert_equal expected, @test_post.author_url, 'post author url not formatted correctly'
  end

  test 'date formatted correctly' do    
    year_link = "/blog/#{self.year}"
    month_link = "#{year_link}/#{self.month}"
    day_link = "#{month_link}/#{self.day}"
    expected = " #{link_to Date::MONTHNAMES[self.month], month_link} "
    expected << "#{link_to self.day, day_link}, "
    expected << "#{link_to self.year, year_link}"

    assert_equal expected, @test_post.formatted_date, 'date not formatted correctly'
  end

  # TODO: test top_level_comments

  # TODO: test approved_comments
end
