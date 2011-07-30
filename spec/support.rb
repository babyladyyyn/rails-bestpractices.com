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
          # NOTE: Just like we don't test the internals of ActiveRecord, we don't test Gravtastic
          # as well ... We just wanna make sure the side effect is present, namely, the appropriate
          # module is included.
          should_include_module 'should be gravtastic', 'Gravtastic::InstanceMethods'
        end

        def should_act_as_taggable
          # NOTE: Just like we don't test the internals of ActiveRecord, we don't test ActsAsTaggableOn
          # as well ... We just wanna make sure the side effect is present, namely, the appropriate
          # module is included.
          should_include_module 'should be acting as taggable', /ActsAsTaggableOn::Taggable::/
        end

        def should_have_entries_per_page(count)
          klass = context_klass
          it "should have #{count} entries per page" do
            klass.default_per_page.should equal(count)
          end
        end

        def should_be_commentable(factory_id = nil)
          factory_id ||= default_factory_id
          describe 'being commentable' do
            should_have_many :comments, :dependent => :destroy
          end
        end

        def should_be_tweetable(factory_id = nil, &block)
          factory_id ||= default_factory_id
          describe "being tweetable" do

            before do
              @instance = Factory(factory_id)
            end

            it 'should have tweet title' do
              @instance.tweet_title.should == block.call(@instance)[:title]
            end

            it 'should have tweet path' do
              @instance.tweet_path.should == block.call(@instance)[:path]
            end

          end
        end

        def should_be_voteable(factory_id = nil)
          factory_id ||= default_factory_id
          describe 'being voteable' do

            should_have_many :votes, :dependent => :destroy

            it "should support retrieving of any user's 1st vote" do
              jane, peter = (0..1).map{|_| Factory(:user) }
              instance = Factory(factory_id)
              instance.votes.create(:user => peter)
              instance.votes.create(:user => jane)
              instance.votes.create(:user => jane)
              instance.vote(jane).should == instance.votes[1]
            end

          end
        end

        def should_be_user_ownable(factory_id = nil)
          factory_id ||= default_factory_id
          describe 'being user ownable' do
            should_belong_to :user, :counter_cache => true
          end
        end

        def should_be_markdownable(factory_id = nil)
          factory_id ||= default_factory_id
          describe "being markdownable" do

            it "should generate simple markdown html" do
              raw = "subject\n=======\ntitle\n-----"
              formatted = "<h1>subject</h1>\n\n<h2>title</h2>\n"
              Factory(factory_id, :body => raw).formatted_html.should == formatted
            end

            it "should generate markdown html with <pre><code>" do
              raw = "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
              formatted = "<h1>subject</h1>\n\n<h2>title</h2>\n\n<pre><code>def test\n  puts 'test'\nend\n</code></pre>\n"
              Factory(factory_id, :body => raw).formatted_html.should == formatted
            end

          end
        end

        private

          def default_factory_id
            context_klass.to_s.tableize.singularize.to_sym
          end

          def context_klass
            # NOTE: This part is abit brittle, assumes the the context description to be a
            # stringified class name or the class itself.
            self.description.split('::').inject(Object) {|klass, const| klass.const_get(const) }
          end

          def should_include_module(description, module_name_or_regexp)
            basic_included_modules = Class.new(ActiveRecord::Base).included_modules
            klass_included_modules = context_klass.included_modules
            extra_modules = (klass_included_modules - basic_included_modules).map(&:to_s)

            it(description)do
              case module_name_or_regexp
              when Regexp
                extra_modules.any?{|mod| mod =~ module_name_or_regexp }.should be_true
              else
                extra_modules.should include(module_name_or_regexp.to_s)
              end
            end
          end

      end

      module InstanceMethods

        def within_observable_scope
          observer_class = self.class.send(:context_klass)
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
