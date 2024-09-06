module SuppliersHelper

  def get_reception(user, buy)
    user.receptions.find_by(buy_id: buy.id)
  end

end
