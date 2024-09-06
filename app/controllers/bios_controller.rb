class BiosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_bio

  def show
    
  end

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to edit_bio_path, notice: 'Tu perfil se ha actualizado.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(@user)
    redirect_to root_path, notice: 'Tu cuenta se ha eliminado'
  end

  private

  def set_user
    @user = current_user
  end

  def set_bio
    @bio = current_user.bio
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password,
      bio_attributes: [:nif, :commercial_name, :phone, :address, :city, :postal_code, :province]
    )
  end
end
