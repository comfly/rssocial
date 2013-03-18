class Subscription < ActiveRecord::Base
  belongs_to :user, :inverse_of => :subscriptions
  belongs_to :feed, :inverse_of => :subscriptions  
  belongs_to :category, :inverse_of => :subscriptions
end
