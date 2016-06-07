class HomeController < ApplicationController
  before_filter :authorize, :index
  layout 'angular'

  def index
  end
end
