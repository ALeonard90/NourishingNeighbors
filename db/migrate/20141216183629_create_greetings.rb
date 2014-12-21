class CreateGreetings < ActiveRecord::Migration
  def change
  	create_table :greetings do |t|
  	t.string :body, null: false
  	t.belongs_to :user, null:false
  	end
	end
end