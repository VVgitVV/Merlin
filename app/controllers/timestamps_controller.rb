class TimestampsController < ApplicationController
  def index
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
  end

  def create
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.new
    @timestamp.timesheet = @timesheet
    @timestamp.start_time = DateTime.now
    if @timestamp.save
      redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def stop
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(end_time: DateTime.now)
    redirect_to client_project_timesheet_timestamps_path(@client, @project, @timesheet)
  end
end
