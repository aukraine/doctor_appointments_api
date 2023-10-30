class TimeSlotPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_a?(Doctor)
        user.time_slots
      elsif user.is_a?(Patient)
        scope.open
      end
    end

    private

    attr_reader :user, :scope
  end

  def index? = doctor?
  def create? = doctor?
  def update? = author?
  def destroy? = author?
  def show_open? = user.is_a?(Patient)

  private

  def author? = record.doctor.id == user.id
  def doctor? = user.is_a?(Doctor)
end