# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :prepare_errors
  # after_action :log_errors
  # after_action :print_errors
  before_action :load_dependencies
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  after_action :generate_events
  rescue_from Github::Error::GithubError, with: :github_error
  rescue_from Github::Error::Unauthorized, with: :github_error

  protected

  # Github::Error::ClientError # Issue with client
  # Github::Error::ServiceError # Service Errors (IE: 404)
  # Github::Error::Unauthorized # github_oauth expired
  def github_error(error)
    @errors << "GitHub encountered an error: Contact support if error persists. Error: #{error.message}" if defined? @errors
    if error.is_a? Github::Error::Unauthorized
      # current_user.update!(github_oauth: nil)
      log_error "Oauth Token Expired: #{error.message}"
      redirect_to project_settings_path, error: contact_support('There was a problem with the GitHub Authentication. You must re-authenticate GitHub.')
    elsif error.is_a? Github::Error::ServiceError
      log_error "GitHub ServiceError: #{error.message}"
      redirect_to project_settings_path, error: contact_support('There was a problem with the GitHub Connection.')
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
    # TODO: Move this require just above where we need it
    require 'dotenv/load' unless Rails.env.production?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[image first_name last_name company location website_url tagline])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[image first_name last_name company location website_url tagline])
  end

  def log_error(msg)
    logger.error msg
    Rollbar.error msg
  end

end
