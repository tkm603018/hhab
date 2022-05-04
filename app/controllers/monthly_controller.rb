class MonthlyController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @utility_water = utility(current_user, '水道代')
    @utility_gas = utility(current_user, 'ガス代')
  end
end
