require 'rails/generators/migration'
require 'rails/generators/active_record'

module Vestige
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::ActiveRecord::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      desc "Add request id column to delayed jobs"

      def copy_migrations
        migration_template "add_trace_id_to_delayed_jobs.rb", "db/migrate/add_trace_id_to_delayed_jobs.rb"
      end
    end
  end
end
