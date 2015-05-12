class CreateJobCameraLogs < ActiveRecord::Migration
  def change
    create_table :job_camera_logs do |t|
      t.string    :job_id,   null: false
      t.string    :job_name, null: false
      t.string    :status,   null: false
      t.text      :arguments
      t.string    :queue_name

      t.timestamp :scheduled_at
      t.timestamp :start_time
      t.timestamp :end_time


      t.timestamp :failed_at
      t.timestamp :retried_at
      t.integer   :retry_counter, defaut: 0
      t.text      :error_message
      t.string    :error_class

      t.timestamps
    end
    add_index :job_camera_logs, [:job_id, :status]
  end
end