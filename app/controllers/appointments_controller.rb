class AppointmentsController < ApplicationController
  before_action :set_resource, except: [:index, :create]

  def index
    authorize Appointment
    params = validate(Appointments::IndexContract)
    @collection = policy_scope(Appointment).upcoming_or_after(params[:started_from].presence || Time.current)

    render json: AppointmentResource.new(collection).serialize, status: :ok
  end

  def create
    authorize Appointment
    params = validate(Appointments::CreateContract)
    @resource = handle_service(BookAppointment, user: current_user, **params)
    serialized = AppointmentResource.new(resource).serialize(meta: { message: 'Record has been successfully created' })

    render json: serialized, status: :created
  end

  def update
    authorize resource
    params = validate(Appointments::UpdateContract)
    handle_service(EditAppointment, appointment: resource, **params)
    serialized = AppointmentResource.new(resource).serialize(meta: { message: 'Record has been successfully updated' })

    render json: serialized, status: :ok
  end

  def destroy
    authorize resource
    handle_service(RemoveAppointment, appointment: resource)

    render json: { message: 'Record has been successfully deleted' }, status: :no_content
  end

  private

  def set_resource = @resource = Appointment.find(params[:id])
end
