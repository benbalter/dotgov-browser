class AddIndexesToDomains < ActiveRecord::Migration
  def change
    add_index :domains, :uri
    add_index :domains, :government
    add_index :domains, :live
    add_index :domains, :ssl
    add_index :domains, :enforce_https
    add_index :domains, :non_www
    add_index :domains, :redirect
    add_index :domains, :ip
    add_index :domains, :hostname
    add_index :domains, :ipv6
    add_index :domains, :dnssec
    add_index :domains, :google_apps
    add_index :domains, :server
    add_index :domains, :slash_data
    add_index :domains, :slash_developer
    add_index :domains, :data_dot_json
    add_index :domains, :click_jacking_protection
    add_index :domains, :content_security_policy
    add_index :domains, :xss_protection
    add_index :domains, :secure_cookies
    add_index :domains, :strict_transport_security
  end
end
