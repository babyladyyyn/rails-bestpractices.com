require 'spec_helper'
require 'rails_best_practices'

describe RailsBestPractices::Plugins::Reviews::NotUseRailsRootReview do
  let(:runner) { RailsBestPractices::Core::Runner.new(:reviews => RailsBestPractices::Plugins::Reviews::NotUseRailsRootReview.new) }

  it "should not use RAILS_ROOT" do
    content =<<-EOF
    class User
      def check
        RAILS_ROOT
      end
    end
    EOF
    runner.review('app/models/user.rb', content)
    runner.should have(1).errors
    runner.errors[0].to_s.should == "app/models/user.rb:3 - not use RAILS_ROOT"
  end

  it "should no not use RAILS_ROOT" do
    content =<<-EOF
    class User
      def check
        Rails.root
      end
    end
    EOF
    runner.review('app/models/user.rb', content)
    runner.should have(0).errors
  end
end
