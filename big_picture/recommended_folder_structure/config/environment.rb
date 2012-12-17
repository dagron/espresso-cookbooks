# encoding: utf-8
require 'bundler'
Bundler.require

ENV['RACK_ENV'] ||= 'development'

$LOAD_PATH.unshift('.')
# Setup load_paths for ActiveSupport
require 'active_support/dependencies'
relative_load_paths = %w(config app/controllers app/models app/presenters app/lib app/workers)
ActiveSupport::Dependencies.autoload_paths = relative_load_paths.map do |path|
  File.expand_path(path, File.dirname(__FILE__) + "/../")
end

if Object.const_defined?(:Encoding) && !ENV['LANG']
  Encoding.default_internal = 'utf-8'
  Encoding.default_external = 'utf-8'
end

require 'e'
