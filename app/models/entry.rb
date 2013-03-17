class Entry < ActiveRecord::Base
  validates :url, presence: true
  validates :published, presence: true

  belongs_to :feed
  has_many :entry_statuses
end
