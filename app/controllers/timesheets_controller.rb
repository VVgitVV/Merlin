class TimesheetsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @timesheets = Timesheet.where(project: params[:project_id])
    @timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
  end

  # take new out of routes for timesheets - will be doing within index page

  def create
    @project = Project.find(params[:project_id])
    @favorite = Favorite.new
    @favorite.project = @project
    if @timesheet.save
      redirect_to __
    else
      render :new, status: :unprocessable_entity
    end
  end
end
