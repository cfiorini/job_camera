require 'rails/generators'
require 'rails/generators/active_record'

module JobCamera
  class InstallGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates (but does not run) a migration to add a versions table.'

    def create_migration_file
      add_job_camera_log_migration('create_job_camera_logs')
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

    protected
    def add_job_camera_log_migration(template)
      migration_dir = File.expand_path('db/migrate')

      unless self.class.migration_exists?(migration_dir, template)
        migration_template "#{template}.rb", "db/migrate/#{template}.rb"
      else
        warn("ALERT: Migration already exists named '#{template}'." +
                 " Please check your migrations directory before re-running")
      end
    end
  end
end
