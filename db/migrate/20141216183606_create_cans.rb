class CreateCans < ActiveRecord::Migration
  def change
  	create_table :cans do |t|
  	  t.integer :num_cans, null: false
  	  t.string :container, null: false
  	  t.string :pickup_time, null: false
  	  t.string :pickup_location, null: false
  	  t.belongs_to :user, null:false
  	end 
  end
end