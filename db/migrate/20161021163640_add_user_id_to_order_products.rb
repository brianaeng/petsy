class AddUserIdToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :user_id, :integer
  end
end
