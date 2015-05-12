require 'job_camera/version'

if defined? Rails && Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 2
  require 'job_camera/engine'
else
  fail 'You must use Rails >= 4.2.0!'
end

module JobCamera
end