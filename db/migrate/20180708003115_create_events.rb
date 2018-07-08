class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :location
      t.string :cost
      t.text :description
      t.integer :user_id
    end 
  end
end
