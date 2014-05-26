class CreateSpreeSales < ActiveRecord::Migration
  def change
    create_table :spree_sales do |t|
      t.string :name
      t.datetime :end_date

      t.timestamps
    end
  end
end
