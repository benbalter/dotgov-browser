class ContentDeliveryNetwork < ActiveRecord::Base

  SHORT_NAME = :cdn

  def self.names
    @names ||= SiteInspector::Endpoint::Dns.new(nil).send(:load_data, :cdn).keys
  end

  validates :name, inclusion: { in: ContentDeliveryNetwork.names }, uniqueness: true, presence: true
end
