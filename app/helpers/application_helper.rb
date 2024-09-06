module ApplicationHelper

  def complete_name(person)
    "#{person.name} #{person.surname1} #{person.surname2}"
  end
  
end
