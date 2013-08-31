require 'ostruct'

class HomeController < ApplicationController

  layout 'home'

  def index
    @blinds = []
    paths = Dir['app/views/home/blinds/*.slim']
    paths.sort!
    paths.each do |p|
      @blinds.push("/#{p}")
    end
  end

  def send_inquiry
    inquiry = OpenStruct.new(params[:inquiry])
    puts inquiry
    InquiryMailer.new_inquiry_notification(inquiry).deliver
    redirect_to '/'
  end
end
