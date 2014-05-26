class AddDeactivationJobIdToSpreeSales < ActiveRecord::Migration
  def change
    add_column :spree_sales, :deactivation_job_id, :string
  end
end
