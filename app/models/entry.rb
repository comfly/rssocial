class Entry < ActiveRecord::Base
  validates :url, presence: true
  validates :published, presence: true

  scope :recent, -> (number_of_items) { order('created_at DESC').limit(number_of_items) }

  belongs_to :feed, :inverse_of => :entries
  has_many :entry_statuses, :inverse_of => :entry, validate: true, :dependent => :destroy 
end
