module JobCamera
  class JobCameraDelete < ActiveJob::Base
    queue_as :default

    def perform(obj)
      obj.destroy
    end
  end
end