require 'swagger_helper'

describe 'Auth API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/login' do
    post 'Authenticate user' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      let(:user) { FactoryBot.create(:doctor, password: password) }

      response '200', 'authenticated' do
        let(:password) { 'good password' }
        let(:credentials) { { email: user.email, password: password } }

        run_test!
      end

      response '401', 'invalid request' do
        let(:credentials) { { email: 'foo', password: 'bar' } }

        run_test!
      end
    end
  end
end