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

end