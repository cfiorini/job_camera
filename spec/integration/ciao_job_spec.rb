require 'rails_helper'

describe CiaoJob do

  let(:jc) { CiaoJob }

  describe '.perform_now' do

    it 'performed response check' do
      expect( jc.perform_now([]) ).to be == 4
    end

    it 'record in database is present' do
      jc.perform_now([])
      expect(JobCamera::JobCameraLog.count).to be > 0
    end

  end

  describe '.perform_later' do

    it 'log enqueue' do
      a = jc.perform_later([])
      job_id = a.job_id
      queue_name = a.queue_name
      class_name = a.class.to_s

      res = JobCamera::JobCameraLog.find_by_job_id_and_queue_name_and_job_name(job_id,
                                                                         queue_name,
                                                                         class_name)

      expect(res).to be_kind_of(JobCamera::JobCameraLog)
    end

  end

end