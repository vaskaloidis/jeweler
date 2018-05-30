class ApplicationController < ActionController::Base
  before_action :load_requires
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_current_user
    User.current_user = current_user
  end

  def configure_permitted_parameters
    keys = [:email, :first_name, :last_name, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  def load_requires
    require 'dotenv/load' unless Rails.env.production?

    require Rails.root.join('lib', 'Array.rb')
    require Rails.root.join('lib', 'Float.rb')
    require Rails.root.join('lib', 'Double.rb')
    require Rails.root.join('lib', 'BigDecimal.rb')
    require Rails.root.join('lib', 'Decimal.rb')
    require Rails.root.join('lib', 'String.rb')
    require Rails.root.join('lib', 'Integer.rb')
    require Rails.root.join('lib', 'NilClass.rb')
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :first_name, :last_name, :company, :location, :website_url, :tagline])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :first_name, :last_name, :company, :location, :website_url, :tagline])
  end

end
