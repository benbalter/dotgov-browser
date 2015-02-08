class Agency < ActiveRecord::Base
  has_many :domains
  validates :name, uniqueness: true, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
