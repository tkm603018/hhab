class UserProfilesController < ApplicationController
  before_action :signed_in_user, only: [:show]

  def show
    @profile = current_user && User.find(current_user.id)
  end
end
