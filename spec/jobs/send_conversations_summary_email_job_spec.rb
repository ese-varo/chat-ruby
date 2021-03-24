require "rails_helper"

RSpec.describe SendConversationsSummaryEmailJob do
  let(:user) { create(:user) }
  before do
    5.times { user.conversations << create(:conversation, messages: create_list(:message, 5)) }
  end

  describe ".perform_later" do
    it "adds the job to the default queue" do
      described_class.perform_later(user)
      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end
end
