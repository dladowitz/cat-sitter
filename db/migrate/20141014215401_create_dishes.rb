class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string   :name,       :null => false
      t.boolean  :vegetarian
      t.boolean  :vegan
      t.boolean  :gluten_free
      t.boolean  :external_vendor
      t.integer  :meal_id,    :null => false

      t.timestamps
    end
  end
end
