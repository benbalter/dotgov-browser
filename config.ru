require "./server"
require 'rack/cache'

use Rack::Cache,
  :metastore   => "file:cache/meta",
  :entitystore => "file:cache/body"

run DotGovBrowser
