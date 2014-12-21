class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  	  t.string :name, null: false
  	  t.string :phonenumber, null: false
  	  t.text :email, null: false, unique: true
  	  t.text :password_digest
  	end
  end
end
