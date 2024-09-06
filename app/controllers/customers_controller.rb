class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    first_customer_id = current_user.customers.first.id
    @customers = current_user.customers.order(created_at: :desc).select{|c| c.id > first_customer_id}
    @filtered_customers = filter_customers(@customers, params[:query])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @sells = @customer.sells
  end

  def new
    @customer = current_user.customers.new
  end

  def create
    @customer = current_user.customers.new(customer_params)

    if CustomerService.create_buy(@customer)
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if CustomerService.update_buy(@customer, customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if CustomerService.destroy_buy(@customer)
      redirect_to customers_url, notice: 'Customer was successfully destroyed.'
    else
      redirect_to customers_url, alert: 'Failed to destroy customer.'
    end
  end

  private

  def set_customer
    @customer = current_user.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:nif, :name, :surname1, :surname2, :phone, :address, :city, :postal_code, :province, :email)
  end

  def filter_customers(customers, query)
    return customers unless query.present?

    customers.where("name ILIKE :query OR surname1 ILIKE :query OR surname2 ILIKE :query OR phone ILIKE :query OR email ILIKE :query", query: "%#{query}%")
  end
end
