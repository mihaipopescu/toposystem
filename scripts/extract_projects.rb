#!/usr/bin/env ruby
# Simple tool to convert the old proiecte.html table into YAML readable
# by Jekyll. Parses "Suprafata" as hectares and extracts a year value.
# Usage:
#   gem install nokogiri
#   ruby scripts/extract_projects.rb path/to/proiecte.html > _data/projects.yml

require 'nokogiri'
require 'yaml'

def parse_area(text)
  return nil if text.nil?
  s = text.strip
  return nil if s.empty? || s == '-' || s =~ /^-+$/
  s2 = s.gsub(/ha/i, '').gsub(',', '.').strip
  Float(s2) rescue nil
end

if ARGV.empty?
  warn "Usage: #{File.basename($0)} path/to/proiecte.html > _data/projects.yml"
  exit 1
end

html_path = ARGV.shift
raw = File.read(html_path, encoding: 'ISO-8859-1')
html = raw.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
doc = Nokogiri::HTML(html)

projects = []
doc.css('table tr').each do |tr|
  cells = tr.css('td').map { |td| td.text.strip }
  next if cells.empty?
  name, client, area_text, date = cells
  next unless name && client && area_text && date
  project = { 'name' => name, 'client' => client, 'area' => area_text, 'date' => date }
  if date =~ /(\d{4})/
    project['year'] = $1.to_i
  end
  if (area_num = parse_area(area_text))
    project['area_num'] = area_num
  end
  projects << project
end

puts projects.to_yaml
