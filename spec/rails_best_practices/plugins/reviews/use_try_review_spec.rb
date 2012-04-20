require 'spec_helper'
require 'rails_best_practices'

module RailsBestPractices
  module Plugins
    module Reviews
      describe UseTryReview do
        let(:runner) { Core::Runner.new(:reviews => UseTryReview.new) }

        it "should use try" do
          content =<<-EOF
          class Post
            def author_name
              author ? author.name : nil
            end
          end
          EOF
          runner.review('app/models/post.rb', content)
          runner.should have(1).errors
          runner.errors[0].to_s.should == "app/models/post.rb:3 - use try (author)"
        end

        it "should use try" do
          content =<<-EOF
          class Post
            def author_name
              author.nil? ? nil : author.name
            end
          end
          EOF
          runner.review('app/models/post.rb', content)
          runner.should have(1).errors
          runner.errors[0].to_s.should == "app/models/post.rb:3 - use try (author)"
        end

        it "should no use try" do
          content =<<-EOF
          class Post
            def author_name
              author.name
            end
          end
          EOF
          runner.review('app/models/post.rb', content)
          runner.should have(0).errors
        end
      end
    end
  end
end
