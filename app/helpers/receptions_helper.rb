module ReceptionsHelper

  def check_completed_lines
    @reception.reception_lines.all? { |line| line.state == "Entregado" }
  end
end
