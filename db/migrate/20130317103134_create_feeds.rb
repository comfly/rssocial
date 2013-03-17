class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url, null: false
      t.string :feed_url, null: false
      t.string :etag
      t.datetime :last_modified, null: false

      t.timestamps
    end
  end
end
