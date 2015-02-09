class AnalyticsProvider < ActiveRecord::Base
  has_and_belongs_to_many :domains

  def self.names
    Sniffles::Sniffers.list_all(:analytics).map { |n| n.to_s }
  end

  validates :name, inclusion: { in: AnalyticsProvider.names }, uniqueness: true, presence: true
end
