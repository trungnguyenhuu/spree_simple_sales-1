class AddDeletedAtToSpreeSales < ActiveRecord::Migration
  def change
    add_column :spree_sales, :deleted_at, :datetime
  end
end
