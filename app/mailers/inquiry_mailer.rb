class InquiryMailer < ActionMailer::Base
  default from: 'noreply@bitpivot.com'

  def new_inquiry_notification(inquiry)
    to = 'info@bitpivot.com'
    subject = "New inquiry from #{inquiry.author} (#{inquiry.email}) #{inquiry.phone}"
    body = inquiry.content
    mail(to: to, subject: subject, body: body)
  end
end
