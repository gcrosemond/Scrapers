#!/usr/bin/env ruby

require "digest"
require "fileutils"
require "optparse"
require "yaml"

options = {
  input: "index.yml",
  output: "dist/index.yml",
  dist: "dist",
  version: nil,
  check: false,
}

OptionParser.new do |parser|
  parser.on("--input PATH") { |value| options[:input] = value }
  parser.on("--output PATH") { |value| options[:output] = value }
  parser.on("--dist PATH") { |value| options[:dist] = value }
  parser.on("--version VERSION") { |value| options[:version] = value }
  parser.on("--check") { options[:check] = true }
end.parse!

entries = YAML.safe_load(File.read(options[:input]), permitted_classes: [], aliases: false)
abort "index must contain a YAML list" unless entries.is_a?(Array)

entries.each do |entry|
  path = entry.fetch("path")
  archive = File.join(options[:dist], path)
  abort "missing release artifact: #{archive}" unless File.file?(archive)

  actual_sha256 = Digest::SHA256.file(archive).hexdigest
  if options[:check]
    abort "checksum mismatch: #{entry.fetch('id')}" unless entry["sha256"] == actual_sha256
  else
    entry["sha256"] = actual_sha256
    entry["version"] = options[:version] if options[:version]
  end
end

if options[:check]
  puts "index checksums OK"
  exit
end

FileUtils.mkdir_p(File.dirname(options[:output]))
File.write(options[:output], YAML.dump(entries))
puts "wrote #{options[:output]}"
