class WorkersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_worker, only: [:show]

  def index
    @workers = current_user.workers
    @filtered_workers = filter_workers(@workers, params[:query])
  end

  def show

  end

  def new
    @worker = User.new(role: :worker, super_user_id: current_user.id)
  end

  def create
    @worker = current_user.workers.build(worker_params)
    service = WorkerCreationService.new(@worker)
    if service
      redirect_to workers_path, notice: 'Trabajador creado con éxito.'
    else
      render :new, notice: "No se pudo crear la persona"
    end
  end

  def edit
    @worker = current_user.workers.find(params[:id])
  end

  def update
    @worker = current_user.workers.find(params[:id])
    if @worker.update(worker_params)
      redirect_to workers_path, notice: 'Trabajador actualizado con éxito.'
    else
      render :edit
    end
  end

  def destroy
    @worker = current_user.workers.find(params[:id])
    @worker.destroy
    redirect_to workers_path, notice: 'Trabajador eliminado con éxito.'
  end

  private

  def worker_params
    params.require(:user).permit(:super_user_id, :email, :password, :password_confirmation, :role, worker_bio_attributes: [:nif, :name, :surname1, :surname2, :address, :city, :postal, :province, :phone])
  end

  def set_worker
    @worker = current_user.workers.find(params[:id])
  end

  def filter_workers(workers, query)
    return workers unless query.present?

    customers.where("name ILIKE :query OR surname1 ILIKE :query OR surname2 ILIKE :query OR phone ILIKE :query OR email ILIKE :query", query: "%#{query}%")
  end

end
