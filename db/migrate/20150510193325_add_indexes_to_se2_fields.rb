class AddIndexesToSe2Fields < ActiveRecord::Migration
  def change
    add_index :domains, :up
    add_index :domains, :www
    add_index :domains, :root
    add_index :domains, :https
    add_index :domains, :enforces_https
    add_index :domains, :canonically_www
    add_index :domains, :canonically_https
    add_index :domains, :hsts
    add_index :domains, :hsts_subdomains
    add_index :domains, :hsts_preload_ready
    add_index :domains, :scheme
    add_index :domains, :external_redirect
    add_index :domains, :doctype
    add_index :domains, :sitemap_xml
    add_index :domains, :robots_txt
    add_index :domains, :cookies
  end
end
