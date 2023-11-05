require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end

ENV['GOOGLE_OAUTH_CLIENT_ID'] = '1039091087765-op1i443tbgg2fi4lrbgiflk21kvds5p8.apps.googleusercontent.com'
ENV['GOOGLE_OAUTH_CLIENT_SECRET'] = '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'
ENV['GOOGLE_DRIVE_CLIENT_ID'] = 'jb8vqjj9mj8nt7rfi10oc1suejqcfou9.apps.googleusercontent.com'
ENV['GOOGLE_DRIVE_CLIENT_SECRET'] = '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'
ENV['GOOGLE_DRIVE_CLIENT_CREDENTIALS'] = '{"type": "service_account","project_id": "assocbaptstudrive","private_key_id": "e9ab7d355bc05ad71b38d68ef64e948d21c6cd25","private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQClHMYw9MwDh1nU\n2xF7jwsBj13L3zehhs5XoNVbkYkYo1jPuLbVs9DSaUAuwoGJWTFwBEYR4q0mveZD\n9UAEBkOq7is3TR4GamMAkZOQfrQy/JAHOh2lmLfyIvs9LcoT77DMNSiWpMd6UbTI\ndJFL8VtJjPgdMo3j+O/BvQ/IVoZRAdekPa3yY65Ye9HhO1GxfNCYoXpRfrtQGto+\n0A/xcvBBc8EQxA652/2DXCRBmBetR34kcfvm43kAOX9rolPQwnKDbRUO9EXweQrF\nMNwzB8UBvMOPjHK0A4gHtCg24Dip0fTBOJdZIHLTCTa65j+4n9cXlgBCL3dkJ45A\nmpHYKK4PAgMBAAECggEAFfWVOwFGZDkV+UlnclZBwaPbzC0Jp48XwK9wdjINbebv\nqAoU2v2EH4UwVue3Na6p9LrEx5qCVTLlaJK6Fa7wRKVSFGlKaH0Gt2vPwznED+c8\n5TvVTJGv8+FeJl1W0RRMSw8jhkwvsYojWpOnmADnbLP1yGBRtF5bzhmt0IMIGxwb\no5wuu0iqIgjkCKoJ57+JuWe3jAg0NjKf8pAm5CZHqXHIW8lFOeIR/ncmfMclKxf3\nfJi51CoogKaH1DK0XP1uFcyJ37M6eCNTodQFYKsvVSExmfM9OUap/2C6emAk4/TX\nWUUgoxggottoaTkrB08YvQmQ05ShcSfKAtqowKC03QKBgQDb9LPPYX/yE9ztyYa6\nar29X1MHUVsAe9CdeJJaNxLkJkX7xXjDm3FZ3EWRfXGnQnu6/hrbz3hMv6DSUfuv\nmHW6FUpfao7CwLTkIBvTtRKLeOlHz2J63PikEPccP49nWM4iF3IgIbThpSHKbBPv\nJHSPeHF+W61O3Pt9JK17iiL61QKBgQDAK1njH9NASJXDtHMrp1Vo7eOa2WqtaOQY\ns536hmOOx5dkvuS4g+r87IVstXI7WNnzba9x/XIOLW0XNHhmgF8nOrkx8Rmb0V6u\nkWT243TTZLvPCC5CzGslG1jpWsLmfWMkN6z3AH58IDiJf5+g0fsexdli06naJ1ao\nxTQ/zVNvUwKBgQDLw/jj0JZAA+iynPRkNEiMbAe2Csc8Pne3uiAS1Vx54X8JzBmh\nVJqAvc/xBX5Jjgyj4Y2uPphauVfaH7sDJEFD3z9j/4o7n1y0zY4Z5XBFpwCt1tCL\ns7PgAht6nuNRwXJNIN1IKRGxzFHufYtGCsa0tsalYXa/TXbpqxXQEdtv9QKBgQC0\nv5G6SVLfoeYLv4ycQLXbDfYIzfrCxGfWvAsZepHl1+GUBuEGlD3QS39rsnaRT48g\nochlhSdkImH7c4TTlGbrdRZ/3PBjWNifhW3bsjFOK+9iWaV5euBEdKZ6Rr4PIVzA\n0gVEBhjyEzRaT8oK77YtSZagl8mowVuHPoVYhX22tQKBgQDRkLHkRyecbmJ5ks8F\nmS3jLpjycqNZCOiboLCn/P4eTAMI1gG7nbNAmV3NgBEZ8tG8cTFd/8R69e1rX0VH\nvRQzFP3IwCGCAgrOhthvywAblCdvsSBs/hLWQoEtEqzai2PQaMWXAR5PEvnZ5eB8\nBeh8Ch+k83esDydKzxlhL5TENQ==\n-----END PRIVATE KEY-----\n","client_email": "assocbaptstudrive@assocbaptstudrive.iam.gserviceaccount.com","client_id": "103639999019362304236","auth_uri": "https://accounts.google.com/o/oauth2/auth","token_uri": "https://oauth2.googleapis.com/token","auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/assocbaptstudrive%40assocbaptstudrive.iam.gserviceaccount.com","universe_domain": "googleapis.com"}'
