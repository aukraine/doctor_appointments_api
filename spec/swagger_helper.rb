require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'Doctor Appointments API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json

  config.swagger_strict_schema_validation = true

  config.before(:each, type: :request) do |example|
    auth_header_parameter = { name: 'HTTP_AUTHORIZATION', in: :header, type: :string, required: true }
    parameters = example.metadata[:example_group][:operation][:parameters]
    extended_parameters = (parameters ? parameters : []) << auth_header_parameter

    example.metadata[:example_group][:operation][:parameters] = extended_parameters
  end

  config.after(:each, type: :request) do |example|
    next if response.nil? || example.metadata[:swagger_doc].nil?

    json_content = response.header['Content-Type'].include?('application/json')
    response_body = json_content ? JSON.parse(response.body) : response.body

    example.metadata[:response][:content] = { 'application/json' => { example: response_body } }

    request_example = example.metadata[:request_example]
    if request_example && respond_to?(request_example)
      parameters = example.metadata[:path_item][:parameters]
      param = parameters.detect { |item| item[:name] == request_example }

      param[:schema][:example] = public_send(request_example)
    end
  end
end
