$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),"lib")))
require 'sisyphus/server'

run Sisyphus::Server
