require 'csv'
require 'open-uri'
require 'site-inspector'

csv = "https://raw.githubusercontent.com/GSA/data/gh-pages/dotgov-domains/2014-12-01-federal.csv"
data = open(csv).read
domains = CSV.parse(data, :headers => true)

domains.each do |d|
  agency = Agency.find_or_create_by :name => d["Agency"]
  Domain.find_or_create_by :host => d["Domain Name"], :agency => agency
end

puts "Agencies: #{Agency.count}"
puts "Domains:  #{Domain.count}"
