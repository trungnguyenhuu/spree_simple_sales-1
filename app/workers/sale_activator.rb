require 'sidekiq'

class SaleActivator
  include Sidekiq::Worker

  def perform(sale_id)
    sale = Spree::Sale.find sale_id
    sale.activate!
  end
end
