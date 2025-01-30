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
    # just for test purposes
    # @timestamp.end_time = DateTime.now + 2.hours
    render :new, status: :unprocessable_entity unless @timestamp.save
  end

  def stop
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.find(params[:id])
    # @timestamp = @timesheet.timestamps.last
    @timestamp.update(end_time: DateTime.now)
    redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
  end
end
