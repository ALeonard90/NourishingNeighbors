class CreateDonations < ActiveRecord::Migration
  def change
  	create_table :donations do |t|
  	t.string :body, null: false
  	t.string :pickup_time, null: false
  	t.string :pickup_location, null: false
  	t.belongs_to :user, null:false
  	end
  end
end
