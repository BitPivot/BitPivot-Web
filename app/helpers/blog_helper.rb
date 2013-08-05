module BlogHelper
  def is_admin_email(email)
    return email =~ /.*\@bitpivot\.com/
  end
end
