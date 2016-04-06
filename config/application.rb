require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FansyPixel
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    # Cross-origin resource sharing
    # It let us keep both UI and API on the same domain
    config.middleware.insert_before 'Rack::Runtime', 'Rack::Cors' do
      allow do
        origins '*'
        resource '*',
                 headers: :any,
                 methods: [:get, :put, :post, :patch, :delete, :options]
      end
    end
  end
end
