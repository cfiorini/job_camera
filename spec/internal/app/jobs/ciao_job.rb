class CiaoJob < ActiveJob::Base
  queue_as :default

  job_camera enqueue: [:before], perform: [:after]

  def perform(*args)
    'ciao'.size
  end
end