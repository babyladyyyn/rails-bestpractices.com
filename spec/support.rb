# NOTE: The followings are quick hacks for now, probably need some refinements later on !!
module RailsBestPractices
  module Spec
    module Support
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      module ClassMethods
        def should_be_gravastic
          it "should include gravastic" do
            described_class.ancestors.should be_include(Gravtastic::InstanceMethods)
          end
        end

        def should_be_tweetable(&block)
          describe "being tweetable" do
            before do
              @instance = FactoryGirl.create(described_class.to_s.underscore)
            end

            it 'should have tweet title' do
              @instance.tweet_title.should == block.call(@instance)[:title]
            end

            it 'should have tweet path' do
              @instance.tweet_path.should == block.call(@instance)[:path]
            end
          end
        end

        def should_be_taggable
          describe 'being taggable' do
            it "should acts_ast_taggable" do
              described_class.ancestors.should be_include(ActsAsTaggableOn::Taggable::Core)
            end
          end
        end

        def should_be_voteable
          describe 'being voteable' do
            it { should have_many(:votes) }

            it "should support retrieving of any user's 1st vote" do
              jane = FactoryGirl.create(:user)
              peter = FactoryGirl.create(:user)
              instance = FactoryGirl.create(described_class.to_s.underscore)
              FactoryGirl.create(:vote, :voteable => instance, :user => peter)
              FactoryGirl.create(:vote, :voteable => instance, :user => jane)
              FactoryGirl.create(:vote, :voteable => instance, :user => jane)
              instance.vote(jane).should == instance.votes[1]
            end
          end
        end

        def should_be_user_ownable
          describe 'being user ownable' do
            it { should belong_to(:user) }
          end
        end

        def should_be_markdownable
          describe "being markdownable" do
            it "should generate simple markdown html" do
              raw = "subject\n=======\ntitle\n-----"
              formatted = "<h1>subject</h1>\n\n<h2>title</h2>\n"
              FactoryGirl.create(described_class.to_s.underscore, :body => raw).formatted_html.should == formatted
            end

            it "should generate markdown html with <pre><code>" do
              raw = "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
              formatted = "<h1>subject</h1>\n\n<h2>title</h2>\n\n<pre><code>def test\n  puts 'test'\nend\n</code></pre>\n"
              FactoryGirl.create(described_class.to_s.underscore, :body => raw).formatted_html.should == formatted
            end
          end
        end
      end
    end
  end
end
