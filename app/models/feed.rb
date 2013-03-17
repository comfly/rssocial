class Feed < ActiveRecord::Base
  validates :url, presence: true
  validates :feed_url, presence: true

  has_many :entries
  
  has_many :user_feeds
  has_many :users, through: :user_feeds
end
