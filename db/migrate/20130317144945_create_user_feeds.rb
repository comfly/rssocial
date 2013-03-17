class CreateUserFeeds < ActiveRecord::Migration
  def change
    create_table :user_feeds do |t|
      t.references :user_id
      t.references :feed_id
    end
  end
end
