# NOTE: The followings are quick hacks for now, probably need some refinements later on !!
module RailsBestPractices
  module Spec
    module Support
      def self.included(base)
        base.class_eval do
          extend ClassMethods
          include InstanceMethods
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
              @instance = Factory(described_class.to_s.underscore)
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
              jane = Factory(:user)
              peter = Factory(:user)
              instance = Factory(described_class.to_s.underscore)
              Factory(:vote, :voteable => instance, :user => peter)
              Factory(:vote, :voteable => instance, :user => jane)
              Factory(:vote, :voteable => instance, :user => jane)
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
              Factory(described_class.to_s.underscore, :body => raw).formatted_html.should == formatted
            end

            it "should generate markdown html with <pre><code>" do
              raw = "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
              formatted = "<h1>subject</h1>\n\n<h2>title</h2>\n\n<pre><code>def test\n  puts 'test'\nend\n</code></pre>\n"
              Factory(described_class.to_s.underscore, :body => raw).formatted_html.should == formatted
            end
          end
        end
      end

      module InstanceMethods
        def within_observable_scope
          observer_class = self.class.send(:described_class)
          has_applied_tweak, tweaks = apply_observer_tweaks(observer_class)
          begin
            yield(observer_class.instance)
          ensure
            unapply_observer_tweaks(observer_class, tweaks) if has_applied_tweak
          end
        end

        def apply_observer_tweaks(observer_class)
          observer, is_unwanted_observer_initialized = nil
          orig_update_meth = :_original_update_observee_xyz_ # some weird name that should never clash with others

          if ObjectSpace.each_object(observer_class){|o| observer = o }.zero?
            # This is the case when the observer is never meant to exist in this environment
            [true, {:method => orig_update_meth}]
          elsif observer.respond_to?(orig_update_meth)
            # This is the case when the observer is never meant to exist in this environment,
            # yet it has already been tampered with, and we want to undo tampering
            (class << observer_class.instance; self; end).class_eval do
              alias_method :update, orig_update_meth
            end
            [true, {:method => orig_update_meth}]
          end
        end

        def unapply_observer_tweaks(observer_class, tweaks)
          orig_update_meth  = tweaks[:method]
          (class << observer_class.instance; self; end).class_eval do
            alias_method orig_update_meth, :update
            def update(*args) ; end
          end
        end
      end
    end
  end
end
