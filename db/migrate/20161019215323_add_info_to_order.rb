class AddInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :orders, :buyer_id, :integer
    add_column :orders, :status, :string
  end
end
