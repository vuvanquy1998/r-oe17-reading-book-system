require "rails_helper"
RSpec.describe Notification, type: :model do
  describe "scope" do
    before :each do
      @notifi1 = Notification.create(used_send: 1, user_receive: 1,
        activity_type: "like", activity_id: 1, created_at: Time.now())
      @notifi2 = Notification.create(used_send: 1, user_receive: 1,
        activity_type: "done_delete", activity_id: 0, created_at: 2.days.ago)
      @notifi3 = Notification.create(used_send: 1, user_receive: 1,
        activity_type: "add_chapter", activity_id: 1, created_at: 1.hours.ago)
    end
    it "order by time" do
      expect(Notification.order_by_time).to eq [@notifi1, @notifi3, @notifi2]
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:used_send).of_type(:integer)}
    it {is_expected.to have_db_column(:user_receive).of_type(:integer)}
    it {is_expected.to have_db_column(:status).of_type(:string)}
    it {is_expected.to have_db_column(:activity_id).of_type(:integer)}
    it {is_expected.to have_db_column(:activity_type).of_type(:string)}
  end
end
