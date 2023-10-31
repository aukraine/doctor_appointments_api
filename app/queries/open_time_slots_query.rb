class OpenTimeSlotsQuery < BaseQuery
  attr_reader :doctor_id, :started_from

  def initialize(relation:, doctor_id: nil, started_from: Time.current, **)
    @relation = relation
    @doctor_id = doctor_id
    @started_from = started_from
  end

  def call
    filter_by_doctor if doctor_id.present?
    filter_by_start_time
    preload_associations

    relation
  end

  def filter_by_doctor
    @relation = relation.where(doctor_id: doctor_id)
  end

  def filter_by_start_time
    @relation = relation.upcoming_or_after(started_from)
  end

  def preload_associations
    @relation = relation.includes(:doctor)
  end
end
