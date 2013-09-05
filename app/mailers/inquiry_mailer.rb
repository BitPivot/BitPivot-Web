class InquiryMailer < ActionMailer::Base
  default from: 'noreply@bitpivot.com'

  def new_inquiry_notification(inquiry)
    to = 'matthew@bitpivot.com'
    subject = "New inquiry from #{inquiry.author} (#{inquiry.email})"
    body = inquiry.content
    mail(to: to, subject: subject, body: body)
  end
end
