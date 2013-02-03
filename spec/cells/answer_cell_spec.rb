require 'spec_helper'

describe AnswerCell do
  context "cell rendering" do

    context "rendering list" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question)
        @answer1 = FactoryGirl.create(:answer, :question => @question)
        @answer2 = FactoryGirl.create(:answer, :question => @question)
      end
      subject { render_cell(:answer, :list, @question, @user) }

      it { should have_selector("h3", :content => "Answers") }
      it { should have_selector(".wikistyle", :content => @answer1.body ) }
      it { should have_selector(".wikistyle", :content => @answer2.body ) }
    end

    context "rendering show" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question)
        @answer = FactoryGirl.create(:answer, :question => @question)
      end
      subject { render_cell(:answer, :show, @question, @answer, @user) }

      it { should have_selector(".wikistyle", :content => @answer.body ) }
    end

    context "rendering new" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question)
        @answer = @question.answers.build
      end
      subject { render_cell(:answer, :new, @question, @answer, @user) }

      it { should have_selector("form.answer") }
      it { should have_button("Post Your Answer") }
    end

  end


  context "cell instance" do
    subject { cell(:answer) }

    it { should respond_to(:show) }
  end
end
