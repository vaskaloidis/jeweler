# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :prepare_errors
  after_action :log_errors
  after_action :generate_events
  before_action :load_dependencies
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def generate_events
    if @errors.empty?

      case controller_name
      when 'invitations'
        case action_name
        when 'accept'
          Note.create_event(@project, 'invitation_accepted', @email + ' Accepted Project Invitation')
        when 'decline'
          Note.create_event(@project, 'invitation_declined', @email + ' Declined Project Invitation')
        when 'destroy'
          Note.create_event(@project, 'invitation_deleted', @email + ' Invitation was deleted by Project Owner')
        end
      end

    end
  end

  def prepare_errors
    @errors = []
  end

  def log_errors
    return if @errors.empty?
    @errors.each do |e|
      logger.error 'TasksController Error: ' + e
    end
  end

  def set_current_user
    User.current_user = current_user
  end

  def configure_permitted_parameters
    keys = %i[email first_name last_name password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  def load_dependencies
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
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[image first_name last_name company location website_url tagline])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[image first_name last_name company location website_url tagline])
  end
end
