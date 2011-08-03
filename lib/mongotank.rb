libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'hashie'
require 'indextank'
require "mongotank/version"
require 'mongotank/base'
require 'mongotank/connection'
require 'mongotank/hit'
require 'mongotank/result_set'
require 'mongotank/query'

module MongoTank
end