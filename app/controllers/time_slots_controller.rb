class TimeSlotsController < ApplicationController
  before_action :set_resource, only: [:update, :destroy]

  def index
    authorize TimeSlot
    @collection = policy_scope(TimeSlot).upcoming_or_after(params[:started_from].presence || Time.current)

    render json: TimeSlotResource.new(collection).serialize, status: :ok
  end

  def create
    authorize TimeSlot
    params = validate(TimeSlots::CreateContract)
    @resource = TimeSlot.create!(doctor: current_user, **params)
    serialized = TimeSlotResource.new(resource).serialize(meta: { message: 'Record has been successfully created' })

    render json: serialized, status: :created
  end

  def update
    authorize resource
    params = validate(TimeSlots::UpdateContract, time_slot: resource)
    resource.update!(**params.to_h)
    serialized = TimeSlotResource.new(resource).serialize(meta: { message: 'Record has been successfully updated' })

    render json: serialized, status: :ok
  end

  def destroy
    authorize resource
    resource.destroy

    render json: { message: 'Record has been successfully deleted' }, status: :no_content
  end

  def show_open
    authorize TimeSlot
    params = validate(TimeSlots::ShowOpenContract)
    @collection = OpenTimeSlotsQuery.(relation: policy_scope(TimeSlot), **params)

    render json: TimeSlotCollection.new(collection).serialize, status: :ok
  end

  private

  def set_resource = @resource = TimeSlot.find(params[:id])
end
