require 'spec_helper'
include Stoplight::Providers

describe Jenkins do
  use_vcr_cassette 'jenkins', :record => :new_episodes

  it 'should inherit from from Stoplight::MultiProjectStandard' do
    Jenkins.superclass.should == MultiProjectStandard
  end

  context 'provider' do
    it 'should return the correct provider name' do
      provider = Jenkins.new('url' => 'http://ci.jenkins-ci.org')
      provider.provider.should == 'jenkins'
    end
  end
end
