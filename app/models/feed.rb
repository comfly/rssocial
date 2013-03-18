class Feed < ActiveRecord::Base
  validates :url, presence: true
  validates :feed_url, presence: true

  has_many :entries, :inverse_of => :feed
  
  has_many :subscriptions, :inverse_of => :feed
  has_many :users, :through => :subscriptions
end
