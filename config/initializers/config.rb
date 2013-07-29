require 'ostruct'
require 'yaml'

APP_CONFIG = OpenStruct.new(YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env])