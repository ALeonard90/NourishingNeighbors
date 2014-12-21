class CreateMeals < ActiveRecord::Migration
  def change
  	create_table :meals do |t|
  	  t.string :name, null: false
  	  t.integer :will_feed, null: false
  	  t.string :pickup_time
  	  t.string :pickup_location, null: false
  	  t.belongs_to :user, null:false
  	end 
  end
end