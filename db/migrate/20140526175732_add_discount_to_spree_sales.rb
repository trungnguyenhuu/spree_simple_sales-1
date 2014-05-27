class AddDiscountToSpreeSales < ActiveRecord::Migration
  def change
    add_column :spree_sales, :discount, :integer, default: 0
  end
end
