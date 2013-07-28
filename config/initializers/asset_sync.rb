AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']         # heroku config:set AWS_ACCESS_KEY_ID
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY'] # heroku config:set AWS_SECRET_ACCESS_KEY
  config.fog_directory = ENV['FOG_DIRECTORY']                 # heroku config:set FOG_DIRECTORY

  config.existing_remote_files = 'delete'
  config.manifest = true
  config.gzip_compression = false

  # Ignored files
  config.ignored_files = [
    %r(partials/.*),         # Ignore partials/ folder
    %r(turbolinks.*\.js),    # Ignore turbolinks gem JS
    %r(coffee-script.*\.js), # Ignore coffee script gem JS
    %r(jquery.*\.js),        # Ignore jQuery related JS
    %r(ss-.*\.css)           # Ignore Symbolset CSS
  ]
end
