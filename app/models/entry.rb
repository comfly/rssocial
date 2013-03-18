class Entry < ActiveRecord::Base
  validates :url, presence: true
  validates :published, presence: true

  belongs_to :feed, :inverse_of => :entries
  has_many :entry_statuses, :inverse_of => :entry, touch: true, validate: true, :dependent => :destroy 
end
