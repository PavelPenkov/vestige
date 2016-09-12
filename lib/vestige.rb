require "vestige/version"

require "vestige/railtie" if defined?(Rails.application)
require "vestige/delayed_job" if defined?(Delayed::Plugin)
require "vestige/sidekiq" if defined?(Sidekiq)
require "vestige/faraday" if defined?(Faraday::Middleware)

module Vestige
  TRACE_ID_KEY = "vestige.trace_id".freeze

  def self.trace_id
    Thread.current[TRACE_ID_KEY]
  end

  def self.trace_id=(trace_id)
    Thread.current[TRACE_ID_KEY] = trace_id
  end
end
