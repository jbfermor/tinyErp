class BioService
  def self.create_for_user(user)
    Bio.create(user: user)
  end

  def self.update_bio(bio, params)
    bio.update(params)
  end
end
