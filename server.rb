require 'mongo'
require 'sinatra'
require 'sinatra/reloader'
require "addressable/uri"
require 'uri'

class DotGovBrowser < Sinatra::Base
  include Mongo

  CACHE_TTL = 30

  configure :development do
    register Sinatra::Reloader
  end

  def initialize
    super
    fields.each do |field|
      domains.drop_indexes
      domains.create_index( field )
    end
  end

  def db
    @db ||= begin
      uri = ENV['MONGOHQ_URL'] || ""
      vars = URI.parse(uri)
      db_name = vars.path.empty? ? "dotgov" : vars.path.gsub(/^\//, '')
      db_host = vars.host || "localhost"
      db_port = vars.port || "27017"
      db = Mongo::Connection.new(db_host, db_port).db(db_name)
      db.authenticate(vars.user, vars.password) unless (vars.user.nil? || vars.user.nil?)
      db
    end
  end

  def domains
    @domains ||= db.collection("domains")
  end

  def fields
    @fields ||= domains.find_one.keys.reject { |field| field[0] == "_" }
  end

  def counts
    output = {}
    fields.each { |field| output.merge!({ field => count_groups(field) }) }
    output.sort_by { |key,value| value.count }
  end

  def query_vars
    params.select { |key,value| fields.include?(key) }
  end

  def count_groups(key)
    domains.group({
      :key => key,
      :initial => { :count => 0 },
      :reduce => "function(x,y){ y.count++ }"
    }, query_vars).sort_by { |field| field["count"] }.reverse
  end

  def append_query(query)
    uri = Addressable::URI.new
    uri.query_values = query_vars.merge(query)
    uri.query
  end

  def remove_query(key)
    uri = Addressable::URI.new
    uri.query_values = query_vars.reject! { |k,v| k == key }
    uri.query
  end

  before do
    cache_control :public, max_age: CACHE_TTL
  end

  get "/" do
    redirect "/domains"
  end

  get "/domains" do
    erb( :domains, :locals => { :domains => domains.find(query_vars) } ).gsub( /\n|\t/, "").gsub( /[ ]+/, " ")
  end

  get "/domains/:domain" do
    domain = domains.find_one( :domain => params["domain"] )
    raise Sinatra::NotFound unless domain
    redirects = domains.find :redirect => domain["domain"]
    erb :domain, :locals => { :domain => domain, :redirects => redirects }
  end

end
