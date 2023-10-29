class TimeSlotsController < ApplicationController
  before_action :set_resource, except: [:index, :create]

  def index
    authorize TimeSlot
    @collection = policy_scope(TimeSlot)

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

  private

  def set_resource = @resource = TimeSlot.find(params[:id])

  def validate(contract_class = OnlyIdContract, **options)
    contract = contract_class.new(**options).call(params.to_unsafe_h)
    raise Errors::UnprocessableEntity.new(contract.errors.to_h) if contract.failure?

    contract.to_h
  end
end
