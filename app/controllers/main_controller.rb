class MainController < ApplicationController
  def home
    render(:layout => "landing_page")
  end

end
