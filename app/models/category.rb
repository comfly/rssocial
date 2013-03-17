class Category < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :user
  has_many :user_categories
  has_many :categories, :through => :user_categories
  has_many :feeds  
end
