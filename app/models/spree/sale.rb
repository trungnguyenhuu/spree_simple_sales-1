module Spree
  class Sale < ActiveRecord::Base
    has_and_belongs_to_many :taxons

    attr_accessible :name, :end_date, :discount, :taxon_ids

    validates :name, :end_date,
              presence: true

    after_save :update_async!

    def activate!
      Spree::Product.in_taxons(taxons).readonly(false).find_each do |product|
        product.set_discount(discount)
      end
    end

    def deactivate!(manual_deactivation = false)
      unschedule_current_job if manual_deactivation
      update_column :deactivation_job_id, nil
      Spree::Product.in_taxons(taxons).readonly(false).find_each do |product|
        product.sale_price = 0
        product.save
      end
    end

    def active?
      !!deactivation_job_id
    end

    def taxon_names
      taxons.map(&:permalink).join(', ')
    end

    def taxon_ids=(string_ids)
      super(string_ids.split(','))
    end

    private

    def update_async!
      SaleUpdater.perform_in(5.seconds, self.id)
      schedule_deactivation
    end

    def unschedule_current_job
      Sidekiq::Status.cancel deactivation_job_id
    end

    def schedule_deactivation
      update_column :deactivation_job_id, SaleDeactivator.perform_at(end_date, self.id)
    end
  end
end
