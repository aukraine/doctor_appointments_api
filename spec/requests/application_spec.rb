require 'swagger_helper'

RSpec.describe 'Auth API', type: :request, swagger_doc: 'v1/swagger.json' do
  let(:HTTP_AUTHORIZATION) { 'Bearer JWT' }

  path '/login' do
    post 'authenticates user' do
      tags 'Auth'
      description 'Authenticates current user'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      let(:user) { FactoryBot.create(:doctor, password: 'password') }

      response '200', 'authenticated' do
        let(:payload) { { email: user.email, password: user.password } }

        run_test!
      end

      response '401', 'unauthorized request' do
        let(:payload) { { email: user.email, password: 'foo' } }

        run_test!
      end
    end
  end
end
