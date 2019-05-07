require "rails_helper"
RSpec.describe Book, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many :chapters}
    it {is_expected.to have_many :likes}
    it {is_expected.to have_many :users}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :writers}
    it {is_expected.to have_many :authors}
  end

  context "accept nested attribute" do
    it {is_expected.to accept_nested_attributes_for :chapters}
  end

  context "category" do
    it {is_expected.to validate_presence_of :category_id}
  end

  context "user" do
    it {is_expected.to validate_presence_of :user_id}
  end

  context "name" do
    it {is_expected.to validate_presence_of :name}
  end

  context "description" do
    it {is_expected.to validate_presence_of :description}
  end

  describe "scope" do
    before :each do
      @role = Role.create(id: 1, name: "normal")
      @user = User.create(id: 1, name: "hoanghung", email: "hoanghung123@gmail.com",
        password: "password", password_confirmation: "password")
      @category = Category.create(id: 1, name: "Cong nghe thong tin")
      @book1 = Book.create(user_id: 1, category_id: 1, name: "Book 1",
        description: "Hay", created_at: Time.now(), status: true)
      @book2 = Book.create(user_id: 1, category_id: 1, name: "Book 2",
        description: "Hap dan", created_at: 4.months.ago)
      @book3 = Book.create(user_id: 1, category_id: 1, name: "Book 3",
        description: "Loi cuon", created_at: 3.months.ago)
      @book4 = Book.create(user_id: 1, category_id: 1, name: "Book 4",
        description: "Tuyet voi", created_at: 5.months.ago, status: true)
    end
    it "ordered by time" do
      expect(Book.where.not(name: "Game of thrones").order_by_time).to eq [@book1, @book3, @book2, @book4]
    end
    it "published" do
      expect(Book.where.not(name: "Game of thrones").published).to eq [@book1, @book4]
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
    it {is_expected.to have_db_index(:category_id)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:boolean)}
    it {is_expected.to have_db_column(:description).of_type(:string)}
    it {is_expected.to have_db_column(:image).of_type(:string)}
  end
end
