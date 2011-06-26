class AnswersController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  belongs_to :question

  create! do |success, failure|
    success.html {
      job = Delayed::Job.enqueue(DelayedJob::NotifyAnswer.new(@answer.id))
      redirect_to question_path(@question)
    }
    failure.html { render 'questions/show' }
  end

  update! do |success, failure|
    success.html { redirect_to question_path(@question) }
  end
end
