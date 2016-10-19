class UpdateInfoForUser < ActiveRecord::Migration
  def change
    add_column :users, :authenticated, :boolean
    remove_column :users, :seller, :boolean
  end
end
