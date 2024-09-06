class ReceptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reception, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @receptions = current_user.receptions.order(created_at: :desc)
    @filtered_receptions = filter_receptions(@receptions, params[:query])
    @user = current_user
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @reception_lines = @reception.reception_lines
    @partial_deliveries = @reception.partial_deliveries
    @partial_delivery = current_user.partial_deliveries.new
  end

  def create
    service = ReceptionCreationService.new(current_user, reception_params[:supplier_id], reception_params[:buy_id])
    @reception = service.call

    if @reception.persisted?
      redirect_to @reception, notice: 'Reception was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    service = ReceptionUpdateService.new(@reception, reception_params)

    if service.call
      redirect_to @reception, notice: 'Reception was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reception.destroy
    redirect_to receptions_url, notice: 'Reception was successfully destroyed.'
  end

  def complete
    service = ReceptionCompletionService.new(@reception, current_user)
    service.call
    redirect_to @reception, notice: 'Reception was successfully completed.'
  end

  private

  def set_reception
    @reception = current_user.receptions.find(params[:id])
  end

  def reception_params
    params.require(:reception).permit(:supplier_id, :buy_id, :last_reception_date, :state)
  end

  def filter_receptions(receptions, query)
    if query.present?
      receptions.joins(:supplier).where(
        'suppliers.name ILIKE ? OR receptions.id::text ILIKE ? OR receptions.state ILIKE ?',
        "%#{query}%", "%#{query}%", "%#{query}%"
      )
    else
      receptions
    end
  end
end
