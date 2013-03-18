class Category < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :user, :inverse_of => :categories
  has_many :subscriptions, :inverse_of => :category
end
