require 'date'

class TimesheetsController < ApplicationController
  def index
    @timesheets = Timesheet.all.order(:created_at)
    @timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
    @timestamps = @timesheet.timestamps.where.not(end_time: nil).order(:end_time)
  end

  def create
    raise
    @timesheet = Timesheet.new(timesheet_params)
    if @timesheet.save
      redirect_to client_project_timesheets_path(@timesheet.project.client, @timesheet.project)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:project_id)
  end
end
