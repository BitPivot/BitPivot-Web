require 'ostruct'

class HomeController < ApplicationController
  include ErrorsHelper

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
    inquiry = Inquiry.new(params[:inquiry])
    
    unless inquiry.valid?
      # get hash with full error messages
      flash_error_placeholders(inquiry, [:email, :phone, :content]).each do |k,v|
        flash[k] = v
      end
      # jump to create comment to show errors
      redirect_to "/#inquiry"
      return
    end
    inquiry.save
    InquiryMailer.new_inquiry_notification(inquiry).deliver
    redirect_to '/'
  end
end
