module Spree
  module Admin
    class SalesController < Spree::Admin::BaseController
      before_filter :find_sale, only: [:show, :edit, :destroy, :update]

      def index
        @sales = Spree::Sale.all
      end

      def new
        @sale = Spree::Sale.new
      end

      def create
        @sale = Spree::Sale.new params[:sale]
        if @sale.save
          flash[:success] = Spree.t(:sale_creation_success)
          redirect_to spree.admin_sales_path
        else
          flash[:error] = Spree.t(:sale_creation_error)
          render :new
        end
      end

      def edit; end

      def update
        if @sale.update_attributes(params[:sale])
          flash[:success] = Spree.t(:sale_update_success)
          redirect_to spree.admin_sales_path
        else
          flash[:error] = Spree.t(:sale_update_error)
          render :edit
        end
      end

      def destroy
        @sale.deactivate! true
        @sale.destroy
        redirect_to spree.admin_sales_path
      end

    private

      def find_sale
        @sale = Spree::Sale.find params[:id]
      end

    end
  end
end
