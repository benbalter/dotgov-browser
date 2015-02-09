class ContentManagementSystem < ActiveRecord::Base
  has_many :domains

  SHORT_NAME = :cms

  def self.names
    Sniffles::Sniffers.list_all(:cms).map { |n| n.to_s }
  end

  validates :name, inclusion: { in: ContentManagementSystem.names }, uniqueness: true, presence: true
end
