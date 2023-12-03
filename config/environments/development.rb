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
ENV['GOOGLE_DRIVE_CLIENT_ID'] = 'tb2nod1n2dahtkl1u882s7v6ds3uqq8q.apps.googleusercontent.com'
ENV['GOOGLE_DRIVE_CLIENT_SECRET'] = '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'
ENV['GOOGLE_DRIVE_CLIENT_CREDENTIALS'] = '{"type": "service_account","project_id": "assocbaptstudrive","private_key_id": "353568a0f2ad8dadd3df9e4e6def0bff7aa9e3ea","private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCs1+v5B+8hUAY2\n7i+F+2fAgTnT8zGRPWP5osw4WM3dxcHjjv1s/kRzw42CmX1UJurZsIPfR32gAfKC\nGgSySYbD9Zz5BtyfrUiOezIFI1KVRngFKyeV4UlscwUdKuiazVTdCVUJKNiPQtok\ny2qNBmIu+ZNCrOc/LxTVV5CXuVx2MMyyi9pW3AYNJT1fJg2NgWsJuEwcWD6V/VFb\nnEiOSZtj7C3tEu0IPhHxzRvwY41SmTmIohgCO7hLvbO1tBh7d7JLlV2T3I0rF1ZA\nrs4RpsCarNUFNDNwvWvGXbwe6kbVo+0gb17kFddbVC6r+D6MDpptBMiTcBduB29f\n7LvQ/E3ZAgMBAAECggEAAkz2zCAfPmSaoJKNDrh+SgwDoV7u/aLr42ps/iGtznzl\nDCAJdDDyPPmRDE2kuGuy2+ZDQG6Vgn1kJU0usNIqZA4EjTVagcREX055J6OvuWLw\naAk0rq8KqNHjHd9GAgF9AVraxz4Zm9aPoXEVCv7XFw76tybRW9WcQ7a1qv9W9rpr\n63Tnq2B/C7rsh5jUfWu8o/zfhrVAmfwIaaWna6zylU4oXfIuWcBTCsFXbusu9o0L\n+yWFdEpvBh9VLUBndRTBn98NfBUyxHPccx50Zb5wslnLrq//WHlCgNfmdz1HYGmL\nsoQgyHwDjPo0c5+H1hZJ/6BM8UIPM6OEipBLzFmKgQKBgQDszeKBwldopxDCL8ED\nogYVtaaZ7z8Z+9H6S4i4HrYeHa8daBNpuREaJrX0vYJhlYBu/5gBQiwDZvzccjZP\nKJZ6JQhy+7+uW1RlVhPQ8potrKRU9wapAiObUHRXYY3SDNDG2+jrrwQFYk2HxBmD\nV5xwlYF/JlFxgsUQQHIx5JfxsQKBgQC62rwwSuhE5rmHQo9ewXMZJqB2h6YDeAn2\nzVeg3vwuQgKpxqvizagvuV60FXMn51pfEfDFtgTBi4hoW5SqEvB32BgcP3s29CmV\nwJHvdzv8cXWP28u1h/Rnd6bhtxPjHtVE9zMElislUdJ8HDXBetdJRH8b+IP0XOmx\nK/MlEznAqQKBgGmPBW9OUGSIRIIrg2C5MvkudkucSIauqFVoolNg7VHTbaIwKKcy\nJhuAMhAdAie52vyf1wSImNITcJhcGTWEJD/ijjejXTi94Ysiqca0vmGp2b8+NqvU\nFkc/v/zLscp2iAJ9OQEGjUZRIbppge34efX9zzH8xMVSw8GQ2NbAzbKhAoGAAxft\n96q1z7Y2Khwa/YmcWzU9gNjcEcCiAZkCs2IdsLJdEux8GgQnnaqm+7pDLszwvRQx\n9UP/LikeOAQUIQCxRHqqY4VVh+Jg8d6/S8SglJxYQupzo+y9Sh08AQ6j4KW5CCxD\nhvbpffOt1WouJabf+5GLvS3PGXOUVt+QZfO8iAkCgYAujhhzb2R/E0G7NvoqgrcZ\nx2yWhlNv7P1oMTvH4YBJdsfNeoXhar2kBOBor6/rsQseQBXeRPQtaq5C03Z7I2Ti\n3C1QwZjKTbjmiAaT0CNKt/7NaXnz/e07nt+xui6GdiY/Zqb0DTXbpIDUD/Bv+oVc\nOXK9EPrMP/0JdnUj55IQqQ==\n-----END PRIVATE KEY-----\n","client_email": "assocbaptstudrive3@assocbaptstudrive.iam.gserviceaccount.com","client_id": "118283155186507436781","auth_uri": "https://accounts.google.com/o/oauth2/auth","token_uri": "https://oauth2.googleapis.com/token","auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/assocbaptstudrive3%40assocbaptstudrive.iam.gserviceaccount.com","universe_domain": "googleapis.com"}'
