require 'sidekiq'
require 'sidekiq-status'

class SaleDeactivator
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(sale_id, forced = false)
    sale = Spree::Sale.with_deleted.find(sale_id)
    sale.deactivate!(forced)
  end
end
