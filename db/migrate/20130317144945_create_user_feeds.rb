class CreateUserFeeds < ActiveRecord::Migration
  def change
    create_table :user_feeds do |t|
      t.references :user
      t.references :feed
      t.references :category
    end
  end
end
