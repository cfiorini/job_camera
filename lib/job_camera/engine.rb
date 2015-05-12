require 'job_camera/base'

module JobCamera
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace JobCamera

      paths['app/models'] << 'lib/job_camera/active_record/models'

      ActiveSupport.on_load :active_job do
        ActiveJob::Base.send(:include, JobCamera::Base)
      end

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
      end

    end
  end

end