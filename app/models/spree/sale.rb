module Spree
  class Sale < ActiveRecord::Base
    has_and_belongs_to_many :taxons

    attr_accessible :name, :end_date, :discount, :taxon_ids

    validate :end_date, presence: true

    after_create :activate_async!, :schedule_deactivation

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

    private

    def activate_async!
      SaleActivator.perform_async(self.id)
    end

    def unschedule_current_job
      Sidekiq::Status.unschedule deactivation_job_id
    end

    def schedule_deactivation
      update_column :deactivation_job_id, SaleDeactivator.perform_at(end_date, self.id)
    end
  end
end
