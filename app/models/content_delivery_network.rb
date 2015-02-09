class ContentDeliveryNetwork < ActiveRecord::Base

  def self.names
    SiteInspector.load_data(:cdn).keys
  end

  validates :name, inclusion: { in: ContentDeliveryNetwork.names }, uniqueness: true, presence: true
end
