class Domain < ActiveRecord::Base
  belongs_to :agency

  before_validation :normalize_host
  validate :validate_government_domain
  validates :host, uniqueness: true, presence: true

  BOOLEANS = [:government, :live, :ssl, :enforce_https, :non_www, :ipv6, :dnssec, :google_apps, :slash_data, :slash_developer, :data_dot_json, :click_jacking_protection, :content_security_policy, :xss_protection, :secure_cookies, :secure_cookies]

  BOOLEANS.each do |field|
    validates field, inclusion: { in: [true, false], :message => "must be either true or false" }, :allow_nil => true
  end

  extend FriendlyId
  friendly_id :host, use: [:slugged, :finders]

  def normalize_host
    self.host = host.downcase if host
  end

  def validate_government_domain
    errors.add(:host, "is not a governemnt domain") unless Gman.valid?(self.host)
  end
end
