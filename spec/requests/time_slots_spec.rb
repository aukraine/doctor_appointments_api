require 'swagger_helper'

RSpec.describe 'TimeSlot API', type: :request, swagger_doc: 'v1/swagger.json' do
  let(:HTTP_AUTHORIZATION) { 'Bearer JWT' }
  let(:current_user) { FactoryBot.create(:doctor) }

  before { allow(JsonWebToken).to receive(:decode).and_return({ user_id: current_user.id }) }

  path '/doctor/time_slots' do
    get 'get time slots' do
      tags 'TimeSlots'
      description 'Returns list of doctors time slots'
      produces 'application/json'
      parameter name: :started_from,
                in: :query,
                schema: { type: :string, format: 'date-time' },
                required: false,
                description: 'A filter used to filter by started date and time'

      before { FactoryBot.create(:time_slot, doctor: current_user) }

      response '200', 'time slots list' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(TimeSlotPolicy).to receive(:index?).and_return(false) }

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

    post 'creates time slot' do
      tags 'TimeSlots'
      description 'Creates new time slot from provided data'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          day_of_week: { type: :integer },
          start_time: { type: :string, format: 'date-time' },
          end_time: { type: :string, format: 'date-time' }
        },
        required: ['day_of_week', 'start_time', 'end_time']
      }

      let(:payload) { { day_of_week: day_of_week, start_time: Time.current + 10.minutes, end_time: Time.current + 30.minutes } }
      let(:day_of_week) { 0 }

      response '201', 'time slot created' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(TimeSlotPolicy).to receive(:create?).and_return(false) }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:day_of_week) { 'id' }

        run_test!
      end
    end
  end

  path '/doctor/time_slots/{id}' do
    parameter name: :id, in: :path, schema: { type: :integer }, required: true

    let(:id) { FactoryBot.create(:time_slot, doctor: current_user).id }

    put 'updates time slot' do
      tags 'TimeSlots'
      description 'Updates time slot by given ID'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          day_of_week: { type: :integer },
          start_time: { type: :string, format: 'date-time' },
          end_time: { type: :string, format: 'date-time' }
        },
        required: []
      }

      let(:payload) { { day_of_week: 1, start_time: Time.current + 20.minutes, end_time: Time.current + 40.minutes } }

      response '200', 'time slot updated' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(TimeSlotPolicy).to receive(:update?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 0 }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:payload) { { day_of_week: nil } }

        run_test!
      end
    end

    delete 'deletes time slot' do
      tags 'TimeSlots'
      description 'Deletes time slot by given ID'

      response '200', 'time slot deleted' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(TimeSlotPolicy).to receive(:destroy?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 0 }

        run_test!
      end
    end
  end

  path '/patient/time_slots/open' do
    let(:current_user) { FactoryBot.create(:patient) }

    get 'get open time slots' do
      tags 'TimeSlots'
      description 'Returns list of all doctors open time slots'
      produces 'application/json'
      parameter name: :started_from,
                in: :query,
                schema: { type: :string, format: 'date-time' },
                required: false,
                description: 'A filter used to filter by started date and time'
      parameter name: :doctor_id,
                in: :query,
                schema: { type: :integer },
                required: false,
                description: 'A filter used to filter by doctor ID'

      before { FactoryBot.create(:time_slot) }

      response '200', 'time slots list' do
        run_test!
      end

      response '401', 'unauthorized request' do
        before { allow(JsonWebToken).to receive(:decode).and_return(nil) }

        run_test!
      end

      response '403', 'forbidden action' do
        before { allow_any_instance_of(TimeSlotPolicy).to receive(:show_open?).and_return(false) }

        run_test!
      end

      response '404', 'not found' do
        before { allow(JsonWebToken).to receive(:decode).and_return({ user_id: nil }) }

        run_test!
      end

      response '422', 'unprocessable params' do
        let(:doctor_id) { 'id' }

        run_test!
      end
    end
  end
end
