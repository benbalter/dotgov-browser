class AddFieldsToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :uri, :string
    add_column :domains, :government, :boolean
    add_column :domains, :live, :boolean
    add_column :domains, :ssl, :boolean
    add_column :domains, :enforce_https, :boolean
    add_column :domains, :non_www, :boolean
    add_column :domains, :redirect, :string
    add_column :domains, :ip, :string
    add_column :domains, :hostname, :string
    add_column :domains, :ipv6, :boolean
    add_column :domains, :dnssec, :boolean
    add_column :domains, :google_apps, :boolean
    add_column :domains, :server, :string
    add_column :domains, :slash_data, :boolean
    add_column :domains, :slash_developer, :boolean
    add_column :domains, :data_dot_json, :boolean
    add_column :domains, :click_jacking_protection, :boolean
    add_column :domains, :content_security_policy, :boolean
    add_column :domains, :xss_protection, :boolean
    add_column :domains, :secure_cookies, :boolean
    add_column :domains, :strict_transport_security, :boolean
  end
end
