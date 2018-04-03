class ApplicationController < ActionController::Base
  before_action :load_env_vars

  private
  def load_env_vars
    require 'dotenv/load'
  end
end
