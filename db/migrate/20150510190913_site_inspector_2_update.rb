class SiteInspector2Update < ActiveRecord::Migration
  def change

    #core
    add_column :domains, :up, :boolean
    add_column :domains, :www, :boolean
    add_column :domains, :root, :boolean
    add_column :domains, :https, :boolean
    add_column :domains, :enforces_https, :boolean
    add_column :domains, :canonically_www, :boolean
    add_column :domains, :canonically_https, :boolean
    add_column :domains, :hsts, :boolean
    add_column :domains, :hsts_subdomains, :boolean
    add_column :domains, :hsts_preload_ready, :boolean
    add_column :domains, :scheme, :string
    add_column :domains, :external_redirect, :boolean

    #content
    add_column :domains, :doctype, :string
    add_column :domains, :sitemap_xml, :boolean
    add_column :domains, :robots_txt, :boolean

    #headers
    add_column :domains, :cookies, :boolean

    #cleanup
    remove_column :domains, :live
    remove_column :domains, :ssl
    remove_column :domains, :enforce_https
    remove_column :domains, :non_www

  end
end
