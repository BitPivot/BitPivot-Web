class CommentMailer < ActionMailer::Base
  default from: 'noreply@bitpivot.com'

  def new_comment_notification(comment)
    to = 'info@bitpivot.com'
    subject = "New comment from #{comment.author} (#{comment.email})"
    body = comment.to_email
    mail(to: to, subject: subject, body: body)
  end
end
