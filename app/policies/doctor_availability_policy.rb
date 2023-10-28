class DoctorAvailabilityPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve = user.doctor_availabilities

    private

    attr_reader :user, :scope
  end

  def index? = doctor?
  def create? = doctor?
  def update? = author?
  def destroy? = author?

  private

  def author? = record.doctor.id == user.id
  def doctor? = user.is_a?(Doctor)
end