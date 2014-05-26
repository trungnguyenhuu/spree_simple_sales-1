class RenameTableSpreeSalesTaxonsToSalesTaxons < ActiveRecord::Migration
  def change
    rename_table :spree_sales_taxons, :sales_taxons
  end
end
