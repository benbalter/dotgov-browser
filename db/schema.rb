# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150208204539) do

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "agencies", ["slug"], name: "index_agencies_on_slug", unique: true

  create_table "domains", force: :cascade do |t|
    t.string   "host"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "agency_id"
    t.string   "slug"
    t.string   "uri"
    t.boolean  "government"
    t.boolean  "live"
    t.boolean  "ssl"
    t.boolean  "enforce_https"
    t.boolean  "non_www"
    t.string   "redirect"
    t.string   "ip"
    t.string   "hostname"
    t.boolean  "ipv6"
    t.boolean  "dnssec"
    t.boolean  "google_apps"
    t.string   "server"
    t.boolean  "slash_data"
    t.boolean  "slash_developer"
    t.boolean  "data_dot_json"
    t.boolean  "click_jacking_protection"
    t.boolean  "content_security_policy"
    t.boolean  "xss_protection"
    t.boolean  "secure_cookies"
    t.boolean  "strict_transport_security"
  end

  add_index "domains", ["agency_id"], name: "index_domains_on_agency_id"
  add_index "domains", ["click_jacking_protection"], name: "index_domains_on_click_jacking_protection"
  add_index "domains", ["content_security_policy"], name: "index_domains_on_content_security_policy"
  add_index "domains", ["data_dot_json"], name: "index_domains_on_data_dot_json"
  add_index "domains", ["dnssec"], name: "index_domains_on_dnssec"
  add_index "domains", ["enforce_https"], name: "index_domains_on_enforce_https"
  add_index "domains", ["google_apps"], name: "index_domains_on_google_apps"
  add_index "domains", ["government"], name: "index_domains_on_government"
  add_index "domains", ["hostname"], name: "index_domains_on_hostname"
  add_index "domains", ["ip"], name: "index_domains_on_ip"
  add_index "domains", ["ipv6"], name: "index_domains_on_ipv6"
  add_index "domains", ["live"], name: "index_domains_on_live"
  add_index "domains", ["non_www"], name: "index_domains_on_non_www"
  add_index "domains", ["redirect"], name: "index_domains_on_redirect"
  add_index "domains", ["secure_cookies"], name: "index_domains_on_secure_cookies"
  add_index "domains", ["server"], name: "index_domains_on_server"
  add_index "domains", ["slash_data"], name: "index_domains_on_slash_data"
  add_index "domains", ["slash_developer"], name: "index_domains_on_slash_developer"
  add_index "domains", ["slug"], name: "index_domains_on_slug", unique: true
  add_index "domains", ["ssl"], name: "index_domains_on_ssl"
  add_index "domains", ["strict_transport_security"], name: "index_domains_on_strict_transport_security"
  add_index "domains", ["uri"], name: "index_domains_on_uri"
  add_index "domains", ["xss_protection"], name: "index_domains_on_xss_protection"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

end
