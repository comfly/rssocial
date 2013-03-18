class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 120 }, format: { with: /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$/ }
  validates :password, presence: true, confirmation: true
  
  has_many :categories, :inverse_of => :user
  
  has_many :subscriptions, :inverse_of => :user
  has_many :feeds, :through => :subscriptions
  
  has_many :entry_statuses, :inverse_of => :user
  has_many :entries, :through => :entry_statuses
end
