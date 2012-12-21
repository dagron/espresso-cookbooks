# encoding: utf-8
require 'bundler'
Bundler.require

## preinitialize the RACK_ENV environment variable
ENV['RACK_ENV'] ||= 'development'

## we should use UTF8 encoding by default
if Object.const_defined?(:Encoding) && !ENV['LANG']
  Encoding.default_internal = 'utf-8'
  Encoding.default_external = 'utf-8'
end

$LOAD_PATH.unshift('.')

require 'active_support/dependencies'
relative_load_paths = %w(config app/controllers app/models app/lib)
ActiveSupport::Dependencies.autoload_paths = relative_load_paths.map do |path|
  File.expand_path(path, File.dirname(__FILE__) + "/../")
end
require 'e'

## will pagination
require 'will_paginate'
require 'will_paginate/active_record'
require 'lib/ext/will_paginate'

# this sux
require 'app/controllers/my_app/frontend'
require 'app/controllers/my_app/frontend/pagination'