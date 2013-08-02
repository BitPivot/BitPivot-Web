class HomeController < ApplicationController
  def index
    @blinds = []
    paths = Dir['app/views/home/blinds/*.erb']
    paths.sort!
    paths.each do |p|
      @blinds.push("/#{p}")
    end
  end
end
