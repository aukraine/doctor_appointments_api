class AppointmentsController < ApplicationController
  def create
    authorize Appointment
    params = validate(Appointments::CreateContract)

    @resource = handle_service(BookAppointment, user: current_user, **params)
    serialized = AppointmentResource.new(resource).serialize(meta: { message: 'Record has been successfully created' })

    render json: serialized, status: :created
  end
end
