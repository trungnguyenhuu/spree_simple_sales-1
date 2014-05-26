class RemoveTimestampsFromSalesTaxons < ActiveRecord::Migration
  def change
    remove_column :sales_taxons, :created_at
    remove_column :sales_taxons, :updated_at
  end
end
