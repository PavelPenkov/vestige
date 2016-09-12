module Vestige
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      Vestige.trace_id = env['action_dispatch.request_id']
      @app.call(env)
    end
  end
end
