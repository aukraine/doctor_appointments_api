class DoctorAvailabilitiesController < ApplicationController
  before_action :set_resource, except: [:index, :create]

  def index
    authorize DoctorAvailability

    render json: { data: policy_scope(DoctorAvailability) }, status: :ok
  end

  def create
    authorize DoctorAvailability
    @resource = DoctorAvailability.create!(doctor: current_user, **availability_params)

    render json: { data: @resource, message: 'Record has been successfully created' }, status: :created
  end

  def update
    authorize @resource
    @resource.update!(**availability_params)

    render json: { data: @resource, message: 'Record has been successfully updated' }, status: :ok
  end

  def destroy
    authorize @resource
    @resource.destroy

    render json: { message: 'Record has been successfully deleted' }, status: :no_content
  end

  private

  def availability_params = params.permit(:id, :day_of_week, :start_time, :end_time)
  def set_resource = @resource = DoctorAvailability.find(availability_params[:id])
end
