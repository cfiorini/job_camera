class OneShotJob < ActiveJob::Base
  queue_as :default

  job_camera enqueue: [:before], perform: [:after], delete_on_complete: 3.seconds

  def perform(args = nil)
    Time.now
  end
end