class AddCategoryToFeed < ActiveRecord::Migration
  def change
    change_table :feeds do |t|
      t.references :category
    end
  end
end