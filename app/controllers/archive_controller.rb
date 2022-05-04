class ArchiveController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  helper_method :sort_column, :sort_direction

  def index
    @months = Item.where(user_id: current_user.id).order("purchased_at desc").pluck(:purchased_at).map{|a| a.strftime("%Y-%m")}.group_by(&:itself).transform_values(&:size).to_a
  end

  def subindex
    @items = Item.where(user_id: current_user.id)
    d = Date.parse("#{params[:slug]}-01").all_month
    @items = @items.where(purchased_at: d.map{|a|a.all_day})
    @items = @items.order("#{sort_column} #{sort_direction}")
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
