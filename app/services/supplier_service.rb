class SupplierService
  def self.create_supplier(supplier)
    supplier.save
  end

  def self.update_supplier(supplier, params)
    supplier.update(params)
  end

  def self.destroy_supplier(supplier)
    supplier.destroy
  end
end
