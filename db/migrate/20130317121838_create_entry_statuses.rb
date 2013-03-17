class CreateEntryStatuses < ActiveRecord::Migration
  def change
    create_table :entry_statuses do |t|
      t.boolean :read, null: false, default: false
      t.boolean :starred, null: false, default: false

      t.references :entry

      t.timestamps
    end
  end
end
