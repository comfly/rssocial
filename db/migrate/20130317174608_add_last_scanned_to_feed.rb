class AddLastScannedToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :last_scanned, :datetime
  end
end
