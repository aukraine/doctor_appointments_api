class AppointmentPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve = user.appointments

    private

    attr_reader :user, :scope
  end

  def index? = patient?
  def create? = patient?
  def update? = author?
  def destroy? = author?

  private

  def author? = record.patient.id == user.id
  def patient? = user.is_a?(Patient)
end