require "rails_helper"
RSpec.describe History, type: :model do
  context "validations" do
    it {is_expected.to belong_to :user}
  end
  describe "scope" do
    before :each do
      @role = Role.create(id: 1, name: "normal")
      @user = User.create(id: 1, name: "hvhung", email: "hvhung@gmail.com",
        password: "foobar", password_confirmation: "foobar")
      @history1 = History.create(user_id: 1, activity_type: "add_book",
        activity_id: 1, created_at: Time.now())
      @history2 = History.create(user_id: 1, activity_type: "add_chapter",
        activity_id: 1, created_at: 2.months.ago)
      @history3 = History.create(user_id: 1, activity_type: "add_comment",
        activity_id: 1, created_at: 2.days.ago)
    end
    it "order by time" do
      expect(History.order_by_time).to eq [@history1, @history3, @history2]
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:activity_type).of_type(:string)}
    it {is_expected.to have_db_column(:activity_id).of_type(:integer)}
  end
end
