class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def start_time_cannot_be_in_past
    errors.add(:base, 'Start time can not be in the past') if start_time < Time.current
  end
end
