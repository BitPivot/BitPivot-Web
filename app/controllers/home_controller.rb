class HomeController < ApplicationController
  def view
    @blinds = []
    paths = Dir['app/views/home/blinds/*.erb']
    puts "\nPATHS\n\n #{paths}\n\n"
    paths.sort
    puts "\nPATHS_SORTED\n\n #{paths}\n\n"
    paths.each do |p|
      @blinds.push("/#{p}")
    end
    puts "\nPATHS_WITH_APPENDED_FORWARDSLASH\n\n#{@blinds}\n\n"
  end
end
