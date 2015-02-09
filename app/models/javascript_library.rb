class JavascriptLibrary < ActiveRecord::Base
  has_many :domains

  SHORT_NAME = :javascript

  def self.names
    Sniffles::Sniffers.list_all(:javascript).map { |n| n.to_s }
  end

  validates :name, inclusion: { in: JavascriptLibrary.names }, uniqueness: true, presence: true
end
