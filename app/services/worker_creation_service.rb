class WorkerCreationService
  def initialize(worker)
    @worker = worker
  end

  def call
    @worker.save
  end
end