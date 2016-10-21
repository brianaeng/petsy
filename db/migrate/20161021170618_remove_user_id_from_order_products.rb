class RemoveUserIdFromOrderProducts < ActiveRecord::Migration
  def change
    remove_column :order_products, :user_id, :integer
  end
end
