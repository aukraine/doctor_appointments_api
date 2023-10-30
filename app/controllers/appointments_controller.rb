class AppointmentsController < ApplicationController
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
end
