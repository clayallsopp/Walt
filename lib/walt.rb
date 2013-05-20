require File.expand_path(File.join(File.dirname(__FILE__), "walt/version"))
require 'motion-cocoapods'
require 'bubble-wrap/core'

require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../walt/**/*.rb', __FILE__)))