class BookAppointment < BaseService
  def initialize(time_slot_id:, description:, user:, **)
    @time_slot_id = time_slot_id
    @description = description
    @user = user
  end

  def call
    find_time_slot
    ActiveRecord::Base.transaction do
      update_time_slot
      create_appointment
    end
    # send_email - here is good place to do such business logic

    success(appointment)
  rescue => e
    failure(e)
  end

  private

  attr_reader :user, :time_slot_id, :time_slot, :description, :appointment

  def find_time_slot
    @time_slot = TimeSlot.find(time_slot_id)
  end

  def update_time_slot
    time_slot.update!(status: TimeSlot::BOOKED_STATUS)
  end

  def create_appointment
    @appointment = Appointment.create!(patient: user, description: description, time_slot: time_slot)
  end
end
