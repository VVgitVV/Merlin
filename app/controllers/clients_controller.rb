class ClientsController < ApplicationController
  before_action :set_client, only: [:update]

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to clients_path, alert: 'Client not found.' }
      format.json { render json: { error: 'Client not found' }, status: :not_found }
    end
  end

  def client_params
    params.require(:client).permit(
      :name,
      :email,
      :phone,
      :address,
      :company_name,
      :status,
      :notes
    )
  end
end
