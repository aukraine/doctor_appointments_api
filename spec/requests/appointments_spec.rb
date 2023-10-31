require 'swagger_helper'

RSpec.describe 'Appointment API', type: :request, swagger_doc: 'v1/swagger.json' do
  let(:HTTP_AUTHORIZATION) { 'Bearer JWT' }
  let(:current_user) { FactoryBot.create(:patient) }

  before { allow(JsonWebToken).to receive(:decode).and_return({ user_id: current_user.id }) }

  path '/patient/appointments' do
    get 'get appointments' do
      tags 'Appointments'
      description 'Returns list of patients appointments'
      produces 'application/json'
      parameter name: :started_from,
                in: :query,
                schema: { type: :string, format: 'date-time' },
                required: false,
                description: 'A filter used to filter by started date and time'

      before { FactoryBot.create(:appointment, patient: current_user) }

      response '200', 'appointments list' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(AppointmentPolicy).to receive(:index?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        before { allow(JsonWebToken).to receive(:decode).and_return({ user_id: nil }) }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:started_from) { 'yesterday' }

        run_test!
      end
    end

    post 'creates appointment' do
      tags 'Appointments'
      description 'Creates new appointment from provided data'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          time_slot_id: { type: :integer },
          description: { type: :string }
        },
        required: ['time_slot_id']
      }

      let(:payload) { { time_slot_id: time_slot_id, description: 'description' } }
      let(:time_slot_id) { FactoryBot.create(:time_slot).id }

      response '201', 'appointment created' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(AppointmentPolicy).to receive(:create?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        let(:time_slot_id) { 0 }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:time_slot_id) { 'id' }

        run_test!
      end

      response '500', 'unexpected error occurred' do
        before { allow_any_instance_of(BookAppointment).to receive(:call).and_return({ success: false }) }

        run_test!
      end
    end
  end

  path '/patient/appointments/{id}' do
    parameter name: :id, in: :path, schema: { type: :integer }, required: true

    let(:id) { FactoryBot.create(:appointment, patient: current_user).id }

    put 'updates appointment' do
      tags 'Appointments'
      description 'Updates appointment by given ID'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          time_slot_id: { type: :integer },
          description: { type: :string }
        },
        required: []
      }

      let(:payload) { { time_slot_id: FactoryBot.create(:time_slot).id, description: 'description' } }

      response '200', 'appointment updated' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(AppointmentPolicy).to receive(:update?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 0 }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:payload) { { description: nil } }

        run_test!
      end

      response '500', 'unexpected error occurred' do
        before { allow_any_instance_of(EditAppointment).to receive(:call).and_return({ success: false }) }

        run_test!
      end
    end

    delete 'deletes appointment' do
      tags 'Appointments'
      description 'Deletes appointment by given ID'

      let(:id) { FactoryBot.create(:appointment, patient: current_user).id }

      response '200', 'appointment deleted' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(AppointmentPolicy).to receive(:destroy?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 0 }

        run_test!
      end

      response '500', 'unexpected error occurred' do
        before { allow_any_instance_of(RemoveAppointment).to receive(:call).and_return({ success: false }) }

        run_test!
      end
    end
  end
end
