class ApplicationController < ActionController::Base
  before_action :load_env_vars
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user



  # def after_sign_in_path_for(resource)
  # view_profile_path
  # end

  protected
  def set_current_user
    User.current_user = current_user
  end

  def configure_permitted_parameters
    keys = [:email, :first_name, :last_name, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
    # devise_parameter_sanitizer.for(:account_update).push(keys)
    # devise_parameter_sanitizer.for(:sign_up).push(keys)
  end

  def load_env_vars
    require 'dotenv/load'
  end
end
