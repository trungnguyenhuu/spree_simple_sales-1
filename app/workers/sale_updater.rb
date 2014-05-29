require 'sidekiq'

class SaleUpdater
  include Sidekiq::Worker

  def perform(sale_id)
    sale = Spree::Sale.find sale_id
    sale.deactivate!(true)
    sale.activate!
    sale.schedule_deactivation
  end
end
