# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :prepare_errors
  # after_action :log_errors
  after_action :generate_events
  # after_action :print_errors
  before_action :load_dependencies
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  # rescue_from Github::Error::NotFound, with: :github_error_not_found
  protected

  def github_error_not_found
    if defined? @errors
        @errors << 'Project GitHub URL is invalid'
    end
  end

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

  # Arrays to capture any Errors (display to user)
  # or Fatal issues which we log (and sometimes display to user)
  def prepare_errors
    @errors = []
    @fatals = []
    @notifications = []
  end

  def log_errors
    # TODO: Move this to an ENV Setting
    only_log_fatal = true

    unless only_log_fatal
      unless @errors.empty?
        @errors.each do |e|
          logger.error 'Error: ' + e
        end
      end
    end
    return if @fatals.empty?
    @fatals.each do |f|
      logger.error 'TasksController Error: ' + e
    end
  end

  def print_errors
    j render 'common/print_errors', errors: @errors
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
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[image first_name last_name company location website_url tagline])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[image first_name last_name company location website_url tagline])
  end
end
