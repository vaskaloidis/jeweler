class MainController < ApplicationController
  def home
    render(:layout => "landing_page")
  end

  def authenticated_home
  end
end
