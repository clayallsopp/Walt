require "walt/version"
require 'bubble-wrap/core'
require 'motion-cocoapods'

BW.require File.expand_path('../walt/support/**/*.rb', __FILE__) do
end

BW.require File.expand_path('../walt/**/*.rb', __FILE__) do  
end

Motion::Project::App.setup do |app|
  depends = {}

  ['fade','move'].each {|file|
    _f = File.expand_path("../walt/operation/#{file}.rb", __FILE__)
    depends[_f] ||= []
    depends[_f] << File.expand_path("../walt/operation/base.rb", __FILE__)
  }

  ['image'].each {|file|
    _f = File.expand_path("../walt/asset/#{file}.rb", __FILE__)
    depends[_f] ||= []
    depends[_f] << File.expand_path("../walt/asset/asset.rb", __FILE__)
  }

  app.files_dependencies depends
end