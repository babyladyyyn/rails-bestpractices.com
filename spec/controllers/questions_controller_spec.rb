require 'spec_helper'

describe QuestionsController do
  context "index" do
    before :each do
      user = mock_model(User, :admin? => false)
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:questions).and_return([])
    end

    it "should not allow invalid nav param" do
      questions = double([Question])
      expect(Question).to receive(:order).with("questions.id desc").and_return(questions)
      expect(questions).to receive(:paginate).and_return(questions)
      get :index, :nav => "wssiasbhpnlgw", :order => "desc"
      expect(response).to render_template("questions/index")
      expect(assigns[:questions]).to eq(questions)
    end

    it "should not use not_answered" do
      questions = double([Question])
      expect(Question).to receive(:order).with("questions.id desc").and_return(questions)
      expect(questions).to receive(:paginate).and_return(questions)
      expect(questions).to receive(:where).with(:answers_count => 0).and_return(questions)
      get :index, :nav => "not_answered"
      expect(response).to render_template("questions/index")
      expect(assigns[:questions]).to eq(questions)
    end
  end
end
