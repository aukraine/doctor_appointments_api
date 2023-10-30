class AppointmentPolicy < ApplicationPolicy
  def create? = patient?

  private

  def patient? = user.is_a?(Patient)
end