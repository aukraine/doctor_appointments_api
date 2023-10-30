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

  private

  def patient? = user.is_a?(Patient)
end