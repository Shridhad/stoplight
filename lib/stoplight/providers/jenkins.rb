#
# Stoplight Provider for Jenkins CI (http://jenkinsci.org)
#
# Jenkis inherits from the MultProjectStandard
#

module Stoplight::Providers
  class Jenkins < MultiProjectStandard
    def provider
      'jenkins'
    end

    def projects
      if @response.nil? || @response.parsed_response.nil? || @response.parsed_response['Projects'].nil?
        @projects ||= []
      else
        # Jenkins doesn't return an array when there's only one job...
        @projects ||= [ @response.parsed_response['Projects']['Project'] ].flatten.collect do |project|
          Stoplight::Project.new({
           :name => project['name'],
           :build_url => project['webUrl'],
           :last_build_id => project['lastBuildLabel'],
           :last_build_time => project['lastBuildTime'],
           :last_build_status => status_to_int(project['lastBuildStatus']),
           :current_status => activity_to_int(project['activity'])
          })
        end
      end
    end
  end
end
