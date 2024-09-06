class ProductsReturnLineDestroyService

  def initialize(line)
    @line = line
  end

  def call_destroy
    @line.destroy
  end

end