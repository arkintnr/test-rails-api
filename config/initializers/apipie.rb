Apipie.configure do |config|
  config.app_name                = "TestRailsApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  config.show_all_examples       = true
  config.translate               = false
  config.validate                = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
