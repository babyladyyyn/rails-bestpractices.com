require "spec_helper"

describe NotifyJobWorker do

  describe "perform" do
    it "should notify job to admin" do
      job = FactoryGirl.create(:job)

      allow(mailer).to receive(:deliver)
      expect(NotificationMailer).to receive(:notify_job).with(job).and_return(mailer)
      NotifyJobWorker.new.perform(job.id)
    end
  end
end
