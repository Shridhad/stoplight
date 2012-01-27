require 'spec_helper'
include Stoplight

describe Project do
  context 'initialize' do
    it 'should work when options is empty' do
      project = Project.new

      project.name.should be_nil
      project.build_url.should be_nil
      project.last_build_id.should be_nil
      project.last_build_time.should be_nil
      project.last_build_status.should == 'unknown'
      project.current_status.should == 'unknown'
    end

    it 'should set all options passed in' do
      project = Project.new(
        :name => 'Seth\'s Repository',
        :build_url => 'http://www.example.com',
        :last_build_id => '1',
        :last_build_time => '2012-05-05T07:58:22Z',
        :last_build_status => 1,
        :current_status => 0
      )

      project.name.should == 'Seth\'s Repository'
      project.build_url.should == 'http://www.example.com'
      project.last_build_id.should == '1'
      project.last_build_time.should == DateTime.parse('2012-05-05T07:58:22Z')
      project.last_build_status.should == 'failed'
      project.current_status.should == 'done'
    end
  end

  context 'parse_date' do
    it 'should work for a valid date' do
      project = Project.new(:last_build_time => '2012-05-05T07:58:22Z')
      project.last_build_time.should == DateTime.parse('2012-05-05T07:58:22Z')
    end

    it 'should not raise an exception for an invalid date' do
      lambda { Project.new(:last_build_time => 'invalid_date') }.should_not raise_error
    end

    it 'should assing nil if date parsing fails' do
      project = Project.new(:last_build_time => 'invalid_date')
      project.last_build_time.should be_nil
    end

    it 'should assign nil if the date is nil' do
      project = Project.new
      project.last_build_time.should be_nil
    end
  end

  context 'last_build_status' do
    it 'should work for a build status of 0 (passed)' do
      project = Project.new(:last_build_status => 0)
      project.last_build_status.should == 'passed'
    end

    it 'should work for a build status of 1 (failed)' do
      project = Project.new(:last_build_status => 1)
      project.last_build_status.should == 'failed'
    end

    it 'should work for a build status of -1 (unknown)' do
      project = Project.new(:last_build_status => -1)
      project.last_build_status.should == 'unknown'
    end

    it 'should return unknown for any weird build statuses' do
      project = Project.new(:last_build_status => 'not_a_valid_build_status')
      project.last_build_status.should == 'unknown'
    end
  end

  context 'current_status' do
    it 'should work for a current status of 0 (done)' do
      project = Project.new(:current_status => 0)
      project.current_status = 'done'
    end

    it 'should work for a current status of 1 (building)' do
      project = Project.new(:current_status => 1)
      project.current_status = 'building'
    end

    it 'should work for a current status of -1 (unknown)' do
      project = Project.new(:current_status => -1)
      project.current_status = 'unknown'
    end

    it 'should return unknown for any weird current statuses' do
      project = Project.new(:current_status => 'not_a_valid_current_status')
      project.current_status = 'unknown'
    end
  end

  context 'building?' do
    it 'should return true when the project is building' do
      project = Project.new(:current_status => 1)
      project.building?.should == true
    end

    it 'should return false when the project is not building (done)' do
      project = Project.new(:current_status => 0)
      project.building?.should == false
    end

    it 'should return false when the project is not building (unknown)' do
      project = Project.new(:current_status => -1)
      project.building?.should == false
    end
  end

  context 'built?' do
    it 'should return true when the project is built' do
      project = Project.new(:current_status => 0)
      project.built?.should == true
    end

    it 'should return false when the project is not built (building)' do
      project = Project.new(:current_status => 1)
      project.built?.should == false
    end

    it 'should return false when the project is not built (unknown)' do
      project = Project.new(:current_status => 1)
      project.built?.should == false
    end
  end

  context 'passed?' do
    it 'should return true when the build passed' do
      project = Project.new(:last_build_status => 0)
      project.passed?.should == true
    end

    it 'should return false when the build failed' do
      project = Project.new(:last_build_status => 1)
      project.passed?.should == false
    end

    it 'should return false when the build failed (unknown)' do
      project = Project.new(:last_build_status => -1)
      project.passed?.should == false
    end
  end

  context 'failed?' do
    it 'should return true when the build fails' do
      project = Project.new(:last_build_status => 1)
      project.failed?.should == true
    end

    it 'should return false when the build passes' do
      project = Project.new(:last_build_status => 0)
      project.failed?.should == false
    end

    it 'should return false when the build is unknown' do
      project = Project.new(:last_build_status => -1)
      project.failed?.should == false
    end
  end
end
