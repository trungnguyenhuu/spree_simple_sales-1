class AddDiscountToSpreeSales < ActiveRecord::Migration
  def change
    add_column :spree_sales, :discount, :integerm, default: 0
  end
end
