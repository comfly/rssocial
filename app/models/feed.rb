class Feed < ActiveRecord::Base
  validates :url, presence: true
  validates :feed_url, presence: true

  has_many :entries
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
