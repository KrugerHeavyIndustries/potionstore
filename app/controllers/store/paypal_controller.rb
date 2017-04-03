module Store
  class PaypalController < ApplicationController
    include PayPal::SDK::REST

    before_action :redirect_to_ssl
    skip_before_action :verify_authenticity_token, only: [ :create, :execute ]

    def create
      head :not_found and return if session[:order_id].nil?
      order = ::Order.find(session[:order_id]) # this is a Potionshop Order model representation not a Paypal Order
      @payment = Payment.new(payment_hash(order))
      if @payment.create
        render json: { paymentID: @payment.id }
      end
    end

    def execute
      head :not_found and return if session[:order_id].nil?
      order = ::Order.find(session[:order_id])
      head :not_found and return if !order.pending?

      order.order_time = Time.now
      order.status = 'S'

      unless order.save
        flash[:error] = 'Please fill out all fields'
        head :not_found and return 
      end

      @payment = Payment.find(params['paymentID']) 
      if @payment.execute(payer_id: params['payerID'])
        order.status = 'C'
        order.first_name = @payment.payer.payer_info.first_name
        order.last_name = @payment.payer.payer_info.last_name
        order.email = @payment.payer.payer_info.email
        order.address1 = @payment.payer.payer_info.shipping_address.line1
        order.address2 = @payment.payer.payer_info.shipping_address.line2
        order.city = @payment.payer.payer_info.shipping_address.city
        order.country = @payment.payer.payer_info.shipping_address.country_code
        order.state = @payment.payer.payer_info.shipping_address.state
        order.zipcode = @payment.payer.payer_info.shipping_address.postal_code
        order.licensee_name = order.name
        order.transaction_number = @payment.id
        order.finish_and_save
        session[:order_id] = order.id
      else
        order.status = 'F'
        order.finish_and_save
      end
      render json: { id: @payment.id, state: @payment.state }
    end

    private

    def payment_hash(order)
      {
        intent: 'sale', 
        payer: { payment_method: 'paypal' },
        redirect_urls: { return_url: url_for(controller: 'store/order', action: 'thankyou'), cancel_url: root_url },
        transactions: [
          item_list: {
            items: order.line_items.map(&line_item_hash)
          },
          amount: order.total,
          description: 'This is the sale description'
        ]
      }
    end

    def line_item_hash(item)
      { name: item.product.name, sku: item.product.code, price: item.unit_price.to_f.to_s, currency: 'USD', quantity: item.quantity }
    end
  end
end
