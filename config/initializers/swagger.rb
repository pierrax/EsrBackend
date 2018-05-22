class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis({
  '1.0' => {
      controller_base_path: '',
      api_file_path: 'public/apidocs',
      base_path: ENV['DOMAIN_URL'],
      clean_directory: true,
      "securityDefinitions": {
          "bearer": {
              "type": "apiKey",
              "name": "Authorization",
              "in": "header"
          }
      },
      :attributes => {
          :info => {
              "title" => "DataESR Api documentation",
              "description" => "Explore our API documentation",
              "termsOfServiceUrl" => "",
              "contact" => "",
              "license" => "Apache 2.0",
              "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
          }
      }
  }
})
