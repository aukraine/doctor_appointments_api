class DoctorAvailabilitiesController < ApplicationController
  before_action :set_resource, except: [:index, :create]

  def index
    authorize DoctorAvailability
    @collection = policy_scope(DoctorAvailability)

    render json: AvailabilityResource.new(collection).serialize, status: :ok
  end

  def create
    authorize DoctorAvailability
    params = validate(DoctorAvailabilities::CreateContract)
    @resource = DoctorAvailability.create!(doctor: current_user, **params)
    serialized = AvailabilityResource.new(resource).serialize(meta: { message: 'Record has been successfully created' })

    render json: serialized, status: :created
  end

  def update
    authorize resource
    params = validate(DoctorAvailabilities::UpdateContract)
    resource.update!(**params.to_h)
    serialized = AvailabilityResource.new(resource).serialize(meta: { message: 'Record has been successfully updated' })

    render json: serialized, status: :ok
  end

  def destroy
    authorize resource
    resource.destroy

    render json: { message: 'Record has been successfully deleted' }, status: :no_content
  end

  private

  def set_resource = @resource = DoctorAvailability.find(params[:id])

  def validate(contract_class = OnlyIdContract)
    contract = contract_class.new.call(params.to_unsafe_h)
    raise Errors::UnprocessableEntity.new(contract.errors.to_h) if contract.failure?

    contract.to_h
  end
end
