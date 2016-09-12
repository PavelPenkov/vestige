module Vestige
  module Sidekiq
    class Client
      def call(_worker_class, job, _queue, _redis_pool)
        job[TRACE_ID_KEY] = Vestige.trace_id
        yield
      end
    end

    class Server
      def initialize(logger = ::Rails.logger)
        @logger = logger
      end

      def call(_worker, msg, _queue)
        if @logger.respond_to?(:tagged)
          Vestige.trace_id = msg[TRACE_ID_KEY]
          @logger.tagged(Vestige.trace_id, "sidekiq") { yield }
          Vestige.trace_id = nil
        else
          yield
        end
      end
    end

    class Formatter
      def call(severity, timestamp, _progname, msg)
        tag = Vestige.trace_id ? "[#{Vestige.trace_id}] " : ''
        "#{tag}#{timestamp.utc.iso8601} #{::Process.pid} TID-#{Thread.current.object_id.to_s(36)} #{severity}: #{msg}\n"
      end
    end
  end
end
