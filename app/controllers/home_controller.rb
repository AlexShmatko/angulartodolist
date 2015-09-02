class HomeController < ApplicationController
  before_filter :authorize, :index
  layout 'angular'

  def index
    gon.current_user = current_user
  end
end
