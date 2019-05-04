require "rails_helper"
RSpec.describe Comment, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :book}
  end
  describe "validations" do
    context "content" do
      it {is_expected.to validate_presence_of :content}
    end
  end

  describe "scope" do
    before :each do
      @role = Role.create(id: 1, name: "normal")
      @user = User.create(id: 1, name: "hoanghung", email: "hoanghung123@gmail.com",
        password: "password", password_confirmation: "password")
      @category = Category.create(id: 1, name: "Cong nghe thong tin")
      @book = Book.create(id: 1, user_id: 1, category_id: 1, name: "Book 1",
        description: "Hay")
      @cmt1 = Comment.create(user_id: 1, book_id: 1, content: "Comment1",
        created_at: Time.now())
      @cmt2 = Comment.create(user_id: 1, book_id: 1, content: "Comment2",
        created_at: 6.hours.ago)
      @cmt3 = Comment.create(user_id: 1, book_id: 1, content: "Comment3",
        created_at: 3.days.ago)
      @cmt4 = Comment.create(user_id: 1, book_id: 1, content: "Comment4",
        created_at: 2.months.ago)
    end
    it "order by time" do
      expect(Comment.order_by_time).to eq [@cmt1, @cmt2, @cmt3, @cmt4]
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:book_id).of_type(:integer)}
    it {is_expected.to have_db_index(:book_id)}
    it {is_expected.to have_db_column(:content).of_type(:string)}
  end
end
