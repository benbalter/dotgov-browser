class ContentDeliveryNetwork < ActiveRecord::Base
  has_many :domains

  SHORT_NAME = :cdn

  def self.names
    @names ||= SiteInspector::Endpoint::Dns.new(nil).send(:load_data, :cdn).keys
  end

  def to_s
    name
  end

  validates :name, inclusion: { in: ContentDeliveryNetwork.names }, uniqueness: true, presence: true
end
