class AddTraceIdToDelayedJobs < ActiveRecord::Migration
  def change
    change_table :delayed_jobs do |t|
      t.string :trace_id
    end
  end
end
