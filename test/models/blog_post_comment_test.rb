require 'test_helper'
require 'cgi'

class BlogPostCommentTest < ActiveSupport::TestCase
  def setup
    @test_post = BlogPost.new({
      id: 1,
      file_name: 'blog/live/TestFileName.html.erb',
      title: 'TestTitle',
      subtitle: 'TestSubtitle',
      author: 'TestAuthor',
      year: 2013,
      month: 6,
      day: 1,
      categories: 'things,stuff',
      body: 'Awesome blog content for the masses'
    })
    @test_post.save

    @test_comment = BlogPostComment.new({
      author: 'TestAuthor',
      email: 'test@email.com',
      content: 'TestContent'
    })
    @test_post = BlogPost.find(@test_post.id)
    @test_post.blog_post_comments << @test_comment
    @test_post.save

    @test_comment_response = BlogPostComment.new({
      respond_to_id: @test_comment.id, 
      author: 'TestAuthor',
      email: 'test@bitpivot.com',
      content: 'TestResponseContent'
    })
    @test_post = BlogPost.find(@test_post.id)
    @test_post.blog_post_comments << @test_comment_response
    @test_post.save
  end

  test 'approval_url formatted correctly' do
    expected = "/admin/blog/approve_comment/#{@test_comment.id}"

    assert_equal expected, @test_comment.approval_url, 'approval_url incorrect'
  end

  test 'deletion_url formatted correctly' do
    expected = "/admin/blog/delete_comment/#{@test_comment.id}"

    assert_equal expected, @test_comment.deletion_url, 'deletion_url incorrect'
  end

  test 'formatted_date correct' do
    expected = @test_comment.created_at.to_formatted_s(:long_ordinal)

    assert_equal expected, @test_comment.formatted_date, 'formatted_date incorrect'
  end

  test 'is_admin_comment based on bitpivot domain' do
    expected = @test_comment.email =~ /.*\@bitpivot\.com/

    assert_equal expected, @test_comment.is_admin_comment, 'is_admin_comment incorrect'
  end

  test 'has_responses' do
    assert @test_comment.has_responses, 'has_responses was false for comment with responses'

    assert !@test_comment_response.has_responses, 'has_responses was true for comment without responses'
  end

  test 'respond_to_comment_url formatted correctly' do
    expected = "/blog/respond_to_comment/#{@test_post.id}/#{@test_comment.id}#respond"

    assert_equal expected, @test_comment.respond_to_comment_url(@test_post.id), 'respond_to_comment_url incorrect'
  end

  test 'to_email correctly generates email' do
    expected = "Author:\t#{@test_comment.author}\n"
    expected << "Email:\t#{@test_comment.email}\n"
    expected << "Date:\t#{@test_comment.formatted_date}\n\n"
    expected << "#{CGI.unescapeHTML(@test_comment.content)}"
    
    assert_equal expected, @test_comment.to_email, 'to_email incorrect'
  end
end
