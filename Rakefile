# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require "bundler/gem_tasks"
require "bundler/setup"

$:.unshift("./lib/")
require './lib/walt'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Walt'

  app.pods do
    pod "AFNetworking"
  end
end
