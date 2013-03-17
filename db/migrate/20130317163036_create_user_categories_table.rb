class CreateUserCategoriesTable < ActiveRecord::Migration
  def change
    create_table :user_category, :force => true do |t|
      t.references :user
      t.references :category
    end
  end
end