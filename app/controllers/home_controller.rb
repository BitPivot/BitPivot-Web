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
end
