#!/usr/bin/env ruby
# Build a static PNG of the timeline from the projects data using QuickChart.
# Write output to img/timeline.png.

require 'yaml'
require 'net/http'
require 'uri'
require 'json'

DATA_FILE = '_data/projects.yml'
OUTPUT_FILE = 'img/timeline.png'

projects = YAML.load_file(DATA_FILE)
points = projects.map do |p|
  next unless p['area_num'] && p['year']
  { x: p['year'], y: p['area_num'] }
end.compact

config = {
  type: 'scatter',
  data: { datasets: [{ label: 'Area (ha) vs year', data: points, backgroundColor: 'rgba(54,162,235,0.7)' }] },
  options: {
    scales: {
      x: { type: 'linear', title: { display: true, text: 'Year' } },
      y: { title: { display: true, text: 'Area (ha)' } }
    }
  }
}

uri = URI('https://quickchart.io/chart')
uri.query = URI.encode_www_form(c: config.to_json, width: 800, height: 400)

puts "Requesting chart image..."
res = Net::HTTP.get_response(uri)
if res.is_a?(Net::HTTPSuccess)
  File.write(OUTPUT_FILE, res.body)
  puts "Saved #{OUTPUT_FILE}"
else
  warn "Failed to generate image: #{res.code} #{res.message}"
end
