class AddCcNumberToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cc_number, :string
    add_column :orders, :cc_expiration, :datetime
  end
end
