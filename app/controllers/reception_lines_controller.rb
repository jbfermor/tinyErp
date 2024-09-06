class ReceptionLinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reception_line, only: [:edit, :update, :destroy]

  
  def new
    @reception = current_user.receptions.find(params[:reception_id])
    @reception_line = @reception.reception_lines.new
  end

  def create
    @reception = current_user.receptions.find(params[:reception_id])
    @reception_line = @reception.reception_lines.new(reception_line_params)

    if @reception_line.save
      redirect_to @reception, notice: 'Reception line was successfully created.'
    else
      render @reception, status: :unprocesable_entity
    end
  end

  def update
    service = ReceptionLineUpdateService.new(@reception_line, reception_line_params)

    if service.call
      respond_to do |format|
        format.html { redirect_to @reception_line.reception, notice: 'Reception line was successfully updated.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("reception_line_#{@reception_line.id}", partial: 'reception_lines/reception_line', locals: { reception_line: @reception_line }) }
      end
    else
      render :edit
    end
  end

  def destroy
    reception = @reception_line.reception
    @reception_line.destroy
    respond_to do |format|
      format.html { redirect_to reception, notice: 'Reception line was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove("reception_line_#{@reception_line.id}") }
    end
  end

  private

  def set_reception_line
    @reception_line = ReceptionLine.find(params[:id])
  end

  def reception_line_params
    params.require(:reception_line).permit(:quantity_received)
  end

end
