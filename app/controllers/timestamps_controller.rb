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
    redirect_to new_timesheet_timestamp_path(@timesheet)
    # redirect_to client_project_timesheet_path(@timesheet.project.client, @timesheet.project, @timesheet)
  end

  def edit
    @timestamp = Timestamp.find(params[:id])
  end

  def update
    @timestamp = Timestamp.find(params[:id])
    if @timestamp.update(timestamp_params)
      # getting update method to work from both the timesheet show and the timestamp show
      redirect_to params[:redirect_to] || client_project_timesheet_path(@timesheet.project.client, @timesheet.project, @timesheet)
    else
      render :edit, status: :unprocessable_entity
    end
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
