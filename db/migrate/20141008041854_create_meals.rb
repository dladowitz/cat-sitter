class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string   :name,     :null => false
      t.integer  :event_id, :null => false
      t.integer  :head_count
      t.datetime :start_time

      t.timestamps
    end
  end
end
