# Vestige

Distributed tracing for Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vestige'
```

## Usage

Vestige relies on `ActionDispatch::RequestId` middleware to generate request id, saves it to thread local variable accessible as `Vestige.trace_id` and forwards it to different API clients to enable cross-application tracing. At the moment it's tightly coupled with Rails and supports Sidekiq, delayed_job and Faraday.

### Sidekiq

Add client and server middlewares to `config/initializers/sidekiq.rb`

```ruby
Sidekiq.configure_server do |config|
  config.logger.formatter = Vestige::Sidekiq::Formatter.new

  config.server_middleware do |chain|
    chain.add Vestige::Sidekiq::Server
  end

  config.client_middleware do |chain| # Fan-out support
    chain.add Vestige::Sidekiq::Client
  end
end

Sidekiq.configure_client do |config|
  config.logger.formatter = Vestige::Sidekiq::Formatter.new

  config.client_middleware do |chain|
    chain.add Vestige::Sidekiq::Client
  end
end
```

### delayed_job

Add plugin to `config/initializers/delayed_job.rb`

```ruby
Delayed::Worker.plugins << Vestige::DelayedJob::Plugin
```

### Faraday

Add middleware to Faraday stack

```ruby
connection = Faraday.new("http://example.com") do |conn|
  conn.request :vestige
  conn.response :logger, Rails.logger
end
```

You'll probably want to tag Rails log as well by adding `config.log_tags = [:uuid]` to `config/application.rb`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
