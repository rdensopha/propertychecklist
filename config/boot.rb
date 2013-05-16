require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

#required to fix the merge hash error in yml files, with regard to Psych YAML parser
require 'yaml'

YAML::ENGINE.yamler= 'syck'