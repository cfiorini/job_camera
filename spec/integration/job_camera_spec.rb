require 'rails_helper'

describe CiaoJob do

  let(:jc) { CiaoJob.new }

  describe '.job_camera' do

    it 'default value in job' do
      expect(jc.job_camera).to be == {enqueue: [:before], perform: [:after]}
    end

    it 'default value in job' do

      original_job_camera = CiaoJob.new.job_camera.dup

      CiaoJob.job_camera perform: [ :before ]

      begin
        expect(CiaoJob.new.job_camera).to be == {perform: [:before]}
      ensure
        CiaoJob.job_camera original_job_camera
      end
    end

  end

end