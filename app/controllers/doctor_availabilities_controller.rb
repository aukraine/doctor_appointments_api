class DoctorAvailabilitiesController < ApplicationController
  def index
    render json: { data: DoctorAvailability.all }, status: :ok
  end

  def show
    render json: { data: DoctorAvailability.find(availability_params[:id]) }, status: :ok
  end

  def create
    @availability = DoctorAvailability.create!(doctor: @current_user, **availability_params)

    render json: { data: @availability }, status: :created
  end

  def update
    @availability = DoctorAvailability.find(availability_params[:id])
    @availability.update!(**availability_params)

    render json: { data: @availability }, status: :ok
  end

  def destroy
    DoctorAvailability.find(availability_params[:id]).destroy

    render json: { message: 'record has been successfully deleted' }, status: :no_content
  end

  private

  def availability_params
    params.permit(:id, :day_of_week, :start_time, :end_time)
  end
end
