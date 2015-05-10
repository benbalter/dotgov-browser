class ContentManagementSystem < ActiveRecord::Base
  has_many :domains

  SHORT_NAME = :cms

  def self.names
    require 'sniffles'
    Sniffles::Sniffers.list_all(:cms).map { |n| n.to_s }
  end

  def to_s
    name
  end

  validates :name, inclusion: { in: ContentManagementSystem.names }, uniqueness: true, presence: true
end
