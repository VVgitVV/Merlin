class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @recent_projects = current_user.projects.active.order(created_at: :desc).limit(5)
    @active_timesheets = current_user.timesheets.joins(:timestamps).where(timestamps: { end_time: nil }).distinct
    @total_projects = current_user.projects.count
    @total_clients = current_user.clients.count
  end
end
