require 'spec_helper'
include Stoplight::Providers

describe MultiProjectStandard do
  before do
    stub_sample_response
  end

  it 'should inherit from Stoplight::Provider' do
    MultiProjectStandard.superclass.should == Provider
  end

  context 'provider' do
    it 'should raise an exception' do
      provider = MultiProjectStandard.new('url' => 'http://www.example.com/cc.xml')
      lambda { provider.provider }.should raise_error(Stoplight::Exceptions::NoProviderError)
    end
  end

  context 'projects' do
    before do
      @provider = MultiProjectStandard.new('url' => 'http://www.example.com/cc.xml')
    end

    it 'should return an array of Stoplight::Project' do
      @provider.projects.class.should == Array
      @provider.projects.first.class.should == Stoplight::Project
    end

    it 'should have the correct default project attributes' do
      project = @provider.projects.first

      project.name.should == 'gerrit_master'
      project.build_url.should == 'http://ci.jenkins-ci.org/job/gerrit_master/'
      project.last_build_id.should == '588'
      project.last_build_time.should == DateTime.parse('2012-05-05T07:58:22Z')
    end

    it 'should have the correct :last_build_statuses' do
      projects = @provider.projects

      projects[0].last_build_status.should == 'passed'
      projects[0].current_status.should == 'done'

      projects[1].last_build_status.should == 'failed'
      projects[1].current_status.should == 'building'

      projects[2].last_build_status.should == 'unknown'
      projects[2].current_status.should == 'unknown'
    end
  end

  private
  def stub_sample_response
    body = '
      <Projects>
        <Project webUrl="http://ci.jenkins-ci.org/job/gerrit_master/" name="gerrit_master" lastBuildLabel="588" lastBuildTime="2012-05-05T07:58:22Z" lastBuildStatus="Success" activity="Sleeping"/>
        <Project webUrl="http://ci.jenkins-ci.org/job/infra_plugins_svn_to_git/" name="infra_plugins_svn_to_git" lastBuildLabel="768" lastBuildTime="2010-11-21T16:03:50Z" lastBuildStatus="Failure" activity="Building"/>
        <Project webUrl="http://ci.jenkins-ci.org/job/infra_svnsync/" name="infra_svnsync" lastBuildLabel="21243" lastBuildTime="2011-02-06T18:31:36Z" lastBuildStatus="Unknown" activity="Unknown"/>
      </Projects>
    '

    stub_request(:any, 'http://www.example.com/cc.xml').to_return(:status => 200, :body => body, :headers => { 'Content-Type' => 'application/xml' })
  end
end
