class AnalyticsProvider < ActiveRecord::Base
  has_and_belongs_to_many :domains

  SHORT_NAME = :analytics

  def self.names
    require 'sniffles'
    Sniffles::Sniffers.list_all(:analytics).map { |n| n.to_s }
  end

  def to_s
    name
  end
  
  validates :name, inclusion: { in: AnalyticsProvider.names }, uniqueness: true, presence: true
end
