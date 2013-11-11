class AddOriginalPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :original_price, :decimal
  end
end
