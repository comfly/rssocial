class RenameUserFeedsToSubscriptions < ActiveRecord::Migration
  def change
    rename_table :user_feeds, :subscriptions
  end
end