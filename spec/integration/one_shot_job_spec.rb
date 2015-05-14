require 'rails_helper'

describe OneShotJob do

  let(:jc) { OneShotJob }

  describe '.perform_now' do

    it 'check job_id for job_camera_delete' do
      jc.perform_now([])
      expect(jc.job_camera_delete.job_id).to be_truthy
    end

  end

  describe '.perform_later' do

    it 'log enqueue' do
      jc.perform_later([])
      expect(jc.job_camera_delete.job_id).to be_truthy
    end

  end

end