class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, only: [:edit, :update]

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to client_project_path(@client, @project),
                  notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status, :deadline, :budget)
  end
end
