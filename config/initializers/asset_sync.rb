AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']         # heroku config:set AWS_ACCESS_KEY_ID
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY'] # heroku config:set AWS_SECRET_ACCESS_KEY
  config.fog_directory = ENV['FOG_DIRECTORY']                 # heroku config:set FOG_DIRECTORY

  config.existing_remote_files = 'delete'

  # Invalidate a file on a cdn after uploading files
  # config.cdn_distribution_id = "12345"
  # config.invalidate = ['file1.js']

  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true

  # Ignored files
  config.ignored_files = [
    %r(partials/.*),
    %r(turbolinks-.*\.js)
  ]

  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  # config.manifest = true

  # Fail silently.  Useful for environments such as Heroku
  # config.fail_silently = true
end
