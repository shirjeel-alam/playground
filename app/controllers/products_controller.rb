class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  
  def charge
    begin
      product = Product.find(stripe_params[:product_id])
      charge = process_payment(product, stripe_params[:stripeEmail], stripe_params[:stripeToken])
      flash[:danger] = 'Charge successful'
    rescue Stripe::CardError
      flash[:danger] = 'Charge unsuccessful'
    end
    redirect_to products_path
  end

  private
    def stripe_params
      params.permit :product_id, :stripeEmail, :stripeToken
    end

    def process_payment(product, email, card_token)
      customer = Stripe::Customer.create(email: email, card: card_token )
      Stripe::Charge.create(customer: customer.id, amount: product.stripe_price, description: product.title, currency: 'usd')
    end
end
