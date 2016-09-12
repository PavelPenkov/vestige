module Vestige
  module DelayedJob
    class Plugin < ::Delayed::Plugin
      callbacks do |lifecycle|
        lifecycle.around(:invoke_job) do |job, *args, &block|
          if Rails.logger.respond_to?(:tagged)
            Rails.logger.tagged(job.trace_id, "delayed_job") do
              block.call(job, *args)
            end
          else
            block.call(job, *args)
          end
        end

        lifecycle.before(:enqueue) do |job, *_args, &_block|
          job.trace_id = Vestige.trace_id
        end
      end
    end
  end
end
