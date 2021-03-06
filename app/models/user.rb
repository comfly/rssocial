class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 120 }
  validates :password, presence: true, confirmation: true
  
  has_many :categories, :inverse_of => :user, validate: true, :dependent => :destroy 
  
  has_many :subscriptions, :inverse_of => :user, :dependent => :destroy
  has_many :feeds, :through => :subscriptions
  
  has_many :entry_statuses, :inverse_of => :user, :dependent => :destroy
  has_many :entries, :through => :entry_statuses
end
