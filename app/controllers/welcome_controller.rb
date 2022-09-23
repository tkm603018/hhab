class WelcomeController < ApplicationController
  before_action :logged_out_user, only: [:index]
  
  def index
  end
end
