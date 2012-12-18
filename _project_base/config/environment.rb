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
# add some app folders to load_path
%w(app/lib app/models app/controllers).each do |path|
  $LOAD_PATH.unshift(File.expand_path(path))
end

require 'e'

# try using some helper gem for auto_requiring
# class_loader as a slimer alternative to active_support/dependencies
require 'class_loader'

# since we mount the module 'MyApp::Backend', which consists of several controllers, autoloading
# will stop, when it finds the top-level constant (MyApp::Backend). we need to "preload" all
# controllers, for them to be available. The same rule would apply for every top-level constant,
# that is a namespace for other classes.
ClassLoader.preload 'app/controllers'
