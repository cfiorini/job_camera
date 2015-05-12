require 'generators/job_camera/templates/create_job_camera_logs'
ActiveRecord::Schema.define do
  CreateJobCameraLogs.new.change
end
