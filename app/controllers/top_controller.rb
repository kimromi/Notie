class TopController < ApplicationController
  layout false
  
  def index
    redirect_to "/app" unless session[:auth_service].blank?
  end
  
end
