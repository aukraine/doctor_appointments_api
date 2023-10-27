class AppointmentsController < ApplicationController
  def index
    render json: { data: Appointment.all }, status: :ok
  end

  def show
    render json: { data: Appointment.find(appointment_params[:id]) }, status: :ok
  end

  def create
    appointment = Appointment.create!(**appointment_params)

    render json: { data: appointment }, status: :created
  end

  def update
    appointment = Appointment.find(appointment_params[:id])
    appointment.update!(**appointment_params)

    render json: { data: appointment }, status: :ok
  end

  def destroy
    Appointment.find(appointment_params[:id]).destroy

    render :json, status: :no_content
  end

  private

  def appointment_params
    params.permit(:id, :start_time, :end_time)
  end
end
