class EditAppointment < BaseService
  def initialize(appointment:, description:, time_slot_id:, **)
    @appointment = appointment
    @description = description
    @time_slot_id = time_slot_id
    @update_attrs = {}
  end

  def call
    if time_slot_changed?
      find_time_slot
      extend_update_attrs
    end
    ActiveRecord::Base.transaction do
      update_old_time_slot if time_slot_changed?
      update_appointment
      update_new_time_slot if time_slot_changed?
    end

    success(appointment)
  rescue => e
    failure(e)
  end

  private

  attr_reader :description, :appointment, :time_slot_id, :time_slot, :update_attrs

  def time_slot_changed?
    appointment.time_slot.id != time_slot_id
  end

  def find_time_slot
    @time_slot = TimeSlot.find(time_slot_id)
  end

  def extend_update_attrs
    update_attrs.merge!(time_slot: time_slot, start_time: time_slot.start_time, end_time: time_slot.end_time)
  end

  def update_old_time_slot
    appointment.time_slot.update!(status: TimeSlot::OPEN_STATUS)
  end

  def update_appointment
    appointment.update!(description: description.presence || appointment.description, **update_attrs)
  end

  def update_new_time_slot
    time_slot.update!(status: TimeSlot::BOOKED_STATUS)
  end
end
