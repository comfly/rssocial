class AddUserToEntryStatus < ActiveRecord::Migration
  def change
    change_table :entry_statuses do |t|
      t.references :user
    end
  end
end