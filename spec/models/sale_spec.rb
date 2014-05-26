require 'spec_helper'

describe Spree::Sale do
  let!(:taxon) { create(:taxon) }
  let!(:product) { create(:product) }

  subject! { described_class.new name: 'foo', end_date: 2.days.from_now, discount: 20 }

  before do
    Sidekiq::Testing.fake!

    product.taxons << taxon
    subject.taxons << taxon

    product.reload
    subject.save
  end

  describe '#activate!' do
    before do
      subject.activate!
    end

    it 'set the product on sale' do
      expect(product).to be_on_sale
    end
  end

  describe '#deactivate!' do
    before do
      product.set_discount(20)
      subject.deactivate!
    end

    it 'unset the product on sale' do
      expect(product).to_not be_on_sale
    end
  end

  describe '#active?' do
    context 'With deactivation_job_id' do
      before do
        subject.stub deactivation_job_id: '1223'
      end

      specify { expect(subject).to be_active }
    end

    context 'Without deactivation_job_id' do
      before do
        subject.stub deactivation_job_id: nil
      end

      specify { expect(subject).to_not be_active }
    end
  end
end
