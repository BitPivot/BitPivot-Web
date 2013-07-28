class HomeController < ApplicationController
  def view
    @blinds = []
    paths = Dir['app/views/home/blinds/*.erb']
    paths.each do |p|
      @blinds.push("/#{p}")
    end
  end
end
