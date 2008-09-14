#!/usr/bin/env ruby

Dir["dot/*"].each do |file|
  link_target = File.join(ENV['HOME'], ".#{File.basename(file)}")
  system "ln -v -n -f -s #{File.expand_path(file)} #{link_target}"
end
