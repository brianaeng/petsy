class UpdateInfoForOrderProduct < ActiveRecord::Migration
  def change
    add_column :order_products, :shipped, :boolean
    add_column :order_products, :quantity, :integer
  end
end
