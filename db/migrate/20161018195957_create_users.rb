class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :username
      t.string :provider
      t.boolean :seller

      t.timestamps null: false
    end
  end
end
