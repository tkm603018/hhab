class TopController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
  end
end
