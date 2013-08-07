class CommentMailer < ActionMailer::Base
  default from: 'info@bitpivot.com'

  def new_comment_notification(comment)
    mail(to: 'info@bitpivot.com', subject: 'EAR HOLE', body: 'DICK FOOT')
  end
end
