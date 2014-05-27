Spree::Product.class_eval do
  delegate_belongs_to :master, :sale_price
  attr_accessible :sale_price

  def on_sale?
    variants_including_master.any?{ |v| v.on_sale? }
  end

  def set_discount(discount)
    self.sale_price = (price - (price * discount / 100.0)).round
    self.save
  end
end
