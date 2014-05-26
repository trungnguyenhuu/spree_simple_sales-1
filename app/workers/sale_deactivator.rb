require 'sidekiq'
require 'sidekiq-status'

class SaleDeactivator
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(sale_id)
    sale = Spree::Sale.find(sale_id)
    sale.deactivate!
  end
end
