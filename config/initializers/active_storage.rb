Rails.application.configure do
  config.after_initialize do
    ActiveStorage::Current.url_options = { host: "http://localhost:3000" }
  end
end
