directory 'css'



site_sass_files = FileList.new(
  '_assets/sass/site.sass',
  '_assets/sass/_reset.sass'
)

file 'css/site.css' => site_sass_files do |t|
  puts "Compiling: '#{t.name}'"
  system "sass --force --style compressed _assets/sass/site.sass #{t.name}" or
    abort 'Failed to compile CSS asset. Is SASS installed?'
end



desc 'Compiles SASS to CSS'
task :sass => [
  'css',
  'css/site.css',
]

desc 'Lint compiled CSS'
task :css_lint => :sass do
  system "csslint --ignore=box-model,box-sizing css/site.css"
end



desc 'Puts Jekyll into server-mode with watch enabled'
task :dev do
  system "jekyll server --watch"
end



desc 'Compiles site with Jekyll'
task :jekyll => :sass do
  puts "Compiling site with Jekyll"
  system "jekyll build" or
    abort 'Failed to build site. Is Jekyll installed?'
end

desc 'Builds site'
task :build => [:jekyll]



require 'rake/clean'
CLEAN.include('css')
CLOBBER.include('_site')

task :default => :build
task :lint => :css_lint