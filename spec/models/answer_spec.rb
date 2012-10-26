require 'spec_helper'

describe Answer do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_be_voteable

  should_be_tweetable do |answer|
    {
      :title => "Answer for #{answer.question.title}",
      :path => "questions/#{answer.question.to_param}"
    }
  end

  it { should belong_to(:question) }

end
