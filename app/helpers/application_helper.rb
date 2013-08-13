module ApplicationHelper
end

class String
  def is_i?
     !!(self =~ /^[-+]?[0-9]+$/)
  end
end