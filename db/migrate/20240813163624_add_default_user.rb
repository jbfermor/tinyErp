class AddDefaultUser < ActiveRecord::Migration[7.0]
  def up
    # Crea el cliente desconocido solo si no existe
    User.find_or_create_by!(email: 'jbfermor@gmail.com') do |user|
      user.password = "adminTinyErp1!"
      user.role = "admin"
    end
  end

  def down
    # Opcional: Elimina el cliente desconocido si se desea revertir la migración
    User.find_by(email: 'jbfermor@gmail.com')&.destroy
  end
end
