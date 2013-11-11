class AddSalePriceToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :sale_price, :decimal
  end
end
