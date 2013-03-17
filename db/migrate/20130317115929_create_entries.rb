class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url, null: false
      t.string :author
      t.text :summary
      t.text :content
      t.datetime :published, null: false
      t.string :categories

      t.references :feed
      
      t.timestamps
    end
  end
end
