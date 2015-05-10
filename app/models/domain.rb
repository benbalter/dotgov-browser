class Domain < ActiveRecord::Base
  belongs_to :agency
  belongs_to :content_delivery_network
  belongs_to :content_management_system
  belongs_to :javascript_library
  has_and_belongs_to_many :analytics_providers

  before_validation :normalize_host
  validate :validate_government_domain
  validates :host, uniqueness: true, presence: true

  FIELDS = {
    :basics => [
      :uri,
      :government,
      :up,
      :www,
      :root,
      :canonically_www,
      :canonically_https,
      :scheme,
      :external_redirect,
      :redirect,
    ],

    :network =>[
      :hostname,
      :ip,
      :ipv6,
      :dnssec,
      :google_apps,
    ],

    :technology => [
      :server,
      :content_delivery_network,
      :content_management_system,
      :javascript_library,
      :doctype,
      :sitemap_xml,
      :robots_txt,
      :cookies,
    ],

    :compliance => [
      :slash_data,
      :slash_developer,
      :data_dot_json,
    ],

    :security => [
      :https,
      :enforces_https,
      :click_jacking_protection,
      :content_security_policy,
      :xss_protection,
      :secure_cookies,
      :strict_transport_security,
      :hsts,
      :hsts_subdomains,
      :hsts_preload_ready,
    ]
  }

  def self.booleans
    @booleans ||= Domain.columns_hash.select { |k,v| v.type == :boolean }.keys.map { |k| k.to_sym }
  end

  Domain.booleans.each do |field|
    validates field, inclusion: { in: [true, false], :message => "must be either true or false" }, :allow_nil => true
  end

  extend FriendlyId
  friendly_id :host, use: [:slugged, :finders]

  def cdn
    content_delivery_network.name if content_delivery_network
  end

  def cdn=(name)
    return unless name
    self.content_delivery_network = ContentDeliveryNetwork.find_or_create_by! :name => name
    self.save!
  end

  def cms
    content_management_system.name if content_management_system
  end

  def cms=(name)
    name = name.keys.first.to_s if name.class == Hash
    return if name.to_s.blank?
    self.content_management_system = ContentManagementSystem.find_or_create_by! :name => name
    self.save!
  end

  def javascript
    javascript_library.name if javascript_library
  end

  def javascript=(name)
    name = name.keys.first.to_s if name.class == Hash
    return if name.to_s.blank?
    self.javascript_library = JavascriptLibrary.find_or_create_by! :name => name
    self.save!
  end

  def analytics
    self.analytics_providers.map { |p| p.name }
  end

  def analytics=(names)
    analytics_providers = []
    if names
      names.keys.map { |k| k.to_s }.each do |name|
        self.analytics_providers.push AnalyticsProvider.find_or_create_by! :name => name
      end
    end
    self.save!
  end

  def normalize_host
    self.host = host.downcase.strip if host
  end

  def validate_government_domain
    errors.add(:host, "is not a governemnt domain") unless Gman.valid?(self.host)
  end

  def inspector
    @inspector ||= SiteInspector.inspect(host)
  end

  def crawl!
    hash = inspector.to_h
    hash_to_properties(hash)
    self.save!
  end

  def url
    "http#{"s" if https?}://#{host}"
  end

  def self.find(id_or_host)
    if id_or_host.is_a? Integer
      Domain.find_by :id => id_or_host
    elsif id_or_host.include?(".")
      Domain.find_by :host => id_or_host
    else
      Domain.find_by :slug => id_or_host
    end
  end

  private

  def hash_to_properties(hash)
    hash.each do |key, value|
      if [:cms, :analytics, :javascript, :advertising].include?(key)
        safe_set(key,value)
      elsif value.is_a?(Hash)
        hash_to_properties(value)
      else
        safe_set(key,value)
      end
    end
  end

  def safe_set(key,value)
    self.send("#{key}=", value) if self.respond_to?("#{key}=")
  end
end
