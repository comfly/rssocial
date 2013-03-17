class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  
  belongs_to :category
end
