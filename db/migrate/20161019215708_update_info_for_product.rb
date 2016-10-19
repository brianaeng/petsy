class UpdateInfoForProduct < ActiveRecord::Migration
  def change
    add_column :products, :active, :boolean
    remove_column :products, :exotic, :boolean
    remove_column :products, :farm, :boolean
    remove_column :products, :domestic, :boolean
  end
end
