class ApplicationController < ActionController::Base
  before_action :load_projects


  def load_projects
    @customer_projects = current_user.customer_projects
    @owner_projects = current_user.owner_projects
  end

end
