require 'spec_helper'

describe QuestionsController do
  context "index" do
    before :each do
      user = mock_model(User)
      controller.stub!(:authenticate_user!).and_return(true)
      controller.stub!(:current_user).and_return(user)
    end

    it "should not allow invalid nav param" do
      questions = mock([Question])
      Question.should_receive(:includes).with(:user, :tags).and_return(questions)
      questions.should_receive(:order).with("created_at desc").and_return(questions)
      questions.should_receive(:paginate).and_return(questions)
      get :index, :nav => "wssiasbhpnlgw", :order => "desc"
      response.should render_template("questions/index")
      assigns[:questions].should == questions
    end

    it "should not use not_answered" do
      questions = mock([Question])
      Question.should_receive(:includes).with(:user, :tags).and_return(questions)
      questions.should_receive(:where).with(:answers_count => 0).and_return(questions)
      questions.should_receive(:order).with("created_at desc").and_return(questions)
      questions.should_receive(:paginate).and_return(questions)
      get :index, :nav => "not_answered"
      response.should render_template("questions/index")
      assigns[:questions].should == questions
    end
  end
end
