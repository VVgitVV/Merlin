class TimestampsController < ApplicationController
  def index
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
  end

  def create
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
    @timestamp.timesheet = @timesheet
    @timestamp.start_time = DateTime.now
    render :new, status: :unprocessable_entity unless @timestamp.save
  end
end
