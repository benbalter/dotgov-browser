class Domain < ActiveRecord::Base
  belongs_to :agency
  belongs_to :content_delivery_network
  belongs_to :content_management_system
  belongs_to :javascript_library
  has_and_belongs_to_many :analytics_providers

  before_validation :normalize_host
  validate :validate_government_domain
  validates :host, uniqueness: true, presence: true

  BOOLEANS = [:government, :live, :ssl, :enforce_https, :non_www, :ipv6, :dnssec, :google_apps, :slash_data, :slash_developer, :data_dot_json, :click_jacking_protection, :content_security_policy, :xss_protection, :secure_cookies, :secure_cookies]

  BOOLEANS.each do |field|
    validates field, inclusion: { in: [true, false], :message => "must be either true or false" }, :allow_nil => true
  end

  extend FriendlyId
  friendly_id :host, use: [:slugged, :finders]

  def cdn
    content_delivery_network.name if content_delivery_network
  end

  def cdn=(name)
    self.content_delivery_network = ContentDeliveryNetwork.find_or_create_by :name => name
    self.save!
  end

  def cms
    content_management_system.name if content_management_system
  end

  def cms=(name)
    name = name.keys.first.to_s if name.class == Hash
    self.content_management_system = ContentManagementSystem.find_or_create_by :name => name
    self.save!
  end

  def javascript
    javascript_library.name if javascript_library
  end

  def javascript=(name)
    name = name.keys.first.to_s if name.class == Hash
    self.javascript_library = JavascriptLibrary.find_or_create_by :name => name
    self.save!
  end

  def analytics
    self.analytics_providers.map { |p| p.name }
  end

  def analytics=(names)
    names = names.keys.map { |k| k.to_s }
    analytics_providers = []
    names.each do |name|
      self.analytics_providers.push AnalyticsProvider.new :name => name
    end
    self.save!
  end

  def normalize_host
    self.host = host.downcase if host
  end

  def validate_government_domain
    errors.add(:host, "is not a governemnt domain") unless Gman.valid?(self.host)
  end

  def inspector
    @inspector ||= SiteInspector.new(host)
  end

  def crawl!
    inspector.to_hash.each do |field, value|
      self.send("#{field}=", value) if self.respond_to?("#{field}=")
    end
    self.save!
  rescue
    nil
  end
end
