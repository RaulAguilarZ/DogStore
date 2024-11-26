class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
 # skip_before_action :authenticate_user!, except: [:index, :show]
 before_action :authenticate_user!, except: [:index, :show]
 helper_method :current_user, :user_signed_in?

#  def current_user
#    @current_user ||= User.find(session[:user_id]) if session[:user_id]
#  end

#  def user_signed_in?
#    current_user.present?
#  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Debes iniciar sesión para acceder a esta sección."
    end
  end

  before_action :auto_login_user # Agrega esto en desarrollo/test, no en producción

  private

  def auto_login_user
    unless user_signed_in?
      user = User.first # Obtiene al primer usuario de la base de datos
      sign_in(user) if user.present? # Utiliza el método de Devise para iniciar sesión
    end
  end



end