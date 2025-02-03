class TimestampsController < ApplicationController
  before_action :set_chained_instances
  def show
    @timestamp = Timestamp.find(params[:id])
  end

  def new
    @timestamp = Timestamp.new
  end

  def create
    @timestamp = Timestamp.new
    @timesheet = Timesheet.find(params[:timesheet_id])
    @timestamp.timesheet = @timesheet
    @timestamp.start_time = DateTime.now
    if @timestamp.save!
      redirect_to timesheet_timestamp_path(@timesheet, @timestamp)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def stop
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(end_time: DateTime.now)
    # redirect_to new_timesheet_timestamp_path(@timesheet)
    redirect_to client_project_timesheet_path(@timesheet.project.client, @timesheet.project, @timesheet)
  end

  def edit
    @timestamp = Timestamp.find(params[:id])
  end

  def update
    # this isn't working anymore
    @timestamp = Timestamp.find(params[:id])
    @timestamp.update(timestamp_params)
    redirect_to timesheet_timestamp_path(@timesheet, @timestamp)
  end

  private

  def set_chained_instances
    @timesheet = Timesheet.find(params[:timesheet_id]) if params[:timesheet_id]
    @project = @timesheet.project
  end

  def timestamp_params
    params.require(:timestamp).permit(:task_description)
  end
end
