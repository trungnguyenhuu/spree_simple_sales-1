class CreateTableSpreeSalesTaxons < ActiveRecord::Migration
  def change
    create_table :spree_sales_taxons do |t|
      t.integer :sale_id
      t.integer :taxon_id

      t.timestamps
    end
  end
end
