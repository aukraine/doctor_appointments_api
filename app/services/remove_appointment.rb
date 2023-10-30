class RemoveAppointment < BaseService
  def initialize(appointment:, **)
    @appointment = appointment
  end

  def call
    ActiveRecord::Base.transaction do
      update_time_slot
      remove_appointment
    end

    success
  rescue => e
    failure(e)
  end

  private

  attr_reader :appointment

  def update_time_slot
    appointment.time_slot.update!(status: TimeSlot::OPEN_STATUS)
  end

  def remove_appointment
    appointment.destroy
  end
end
