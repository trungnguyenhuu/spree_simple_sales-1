require 'sidekiq'

class SaleUpdater
  include Sidekiq::Worker

  def perform(sale_id)
    sale = Spree::Sale.find sale_id
    sale.deactivate!(true)
    sale.activate!
    schedule_deactivation
  end
end
