require 'job_camera/jobs/job_camera_delete'

module JobCamera
  module Base
    extend ::ActiveSupport::Concern
    include ::ActiveSupport::Callbacks

    module ClassMethods

      cattr_accessor :job_camera_delete

      #
      # Options
      # :enqueue    [:before, :after]
      # :perform    [:before, :after]
      # :rescue     [TypeError]
      # :logger     nil
      # :notifier
      # :delete_on_complete nil or 5.seconds
      def job_camera(options = {})
        send :include, InstanceMethods

        @jc_options = options.dup if options.present?

        self.logger = @jc_options[:logger] if @jc_options.has_key?(:logger)

        @jc_options[:rescue].map do |klass|
          self.rescue_from klass, with: :rescue_job
        end if @jc_options.has_key?(:rescue) && @jc_options[:rescue].size > 0

        @jc_options[:enqueue].each do |action|
          set_callback :enqueue, action, -> {
            self.camera_log_object_manager(:"#{action}_enqueue")
          }
        end if @jc_options.has_key?(:enqueue) && @jc_options[:enqueue].size > 0

        @jc_options[:perform].map do |action|
          set_callback :perform, action, -> {
            self.camera_log_object_manager(:"#{action}_perform")
          }
        end if @jc_options.has_key?(:perform) && @jc_options[:perform].size > 0

        set_callback :perform, :after, -> {

          self.class.job_camera_delete = JobCamera::JobCameraDelete
                                             .set(wait: self.job_camera[:delete_on_complete])
                                             .perform_later(self.camera_log_object_get)

        }, if: -> { self.job_camera[:delete_on_complete] != nil }

      end

      def job_camera_from_part
        @jc_options
      end
    end


    module InstanceMethods

      def job_camera
        self.class.job_camera_from_part
      end

      def camera_log_object_get
        JobCamera::JobCameraLog.find_or_create_by(job_id: self.job_id,
                                             job_name: self.class.to_s,
                                             queue_name: self.queue_name)
      end

      def camera_log_object_manager(callback_name)

        jc_object = camera_log_object_get

        jc_object.status = callback_name
        jc_object.scheduled_at ||= Time.at(self.scheduled_at) if self.scheduled_at

        if callback_name == :before_perform
          jc_object.increment(:retry_counter)
          jc_object.start_time = Time.now
        end

        jc_object.end_time = Time.now if callback_name == :after_perform

        jc_object.save
      end

      def rescue_job(exception)

        jc_object = camera_log_object_get
        jc_object.failed_at = Time.now
        jc_object.error_class = exception.class
        jc_object.error_message = [exception.message, exception.backtrace].flatten.join("\n")
        jc_object.retried_at = 1.minute.from_now

        jc_object.save

        retry_job(wait_until: jc_object.retried_at)
      end

    end
  end
end