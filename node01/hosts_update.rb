#!/usr/bin/env ruby

require 'json'

nodes = JSON.load(STDIN.gets)
hosts_file = "./node01/_hosts"

File.open(hosts_file, "w") do |f|
  nodes.each do |n|
    f.puts "#{n['Node']}\t #{n['Address']}"
  end

  f.close
end
