require "rails_helper"
RSpec.describe User, type: :model do
  before {@role = Role.create(id: 1, name: "normal")}
  let(:user) {FactoryBot.create :user}
  subject {user}
  context "name" do
    context "valid" do
      it {is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_length_of(:name).is_at_most(Settings.name_max)}
    end
    context "invalid" do
      before {subject.name = "a" * 51}
      it {is_expected.not_to be_valid}
    end
  end

  context "email" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most(Settings.email_max)}
    context "invalid" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |invalid_email|
        it {is_expected.not_to allow_value(invalid_email).for(:email)}
      end
      before {subject.email = FFaker::Internet.email(FFaker::Lorem.characters(255))}
      it {is_expected.not_to be_valid}
    end
    context "valid" do
      emails = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
      emails.each do |invalid_email|
        it {is_expected.to allow_value(invalid_email).for(:email)}
      end
    end
    context "unique" do
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end
  end

  context "password" do
    context "valid" do
      it {is_expected.to validate_length_of(:password).is_at_least(Settings.pass_min)}
      it {is_expected.to have_secure_password}
    end
    context "invalid" do
      before {subject.password = FFaker::Lorem.characters(5)}
      it {is_expected.not_to be_valid}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :role}
    it {is_expected.to have_many :histories}
    it {is_expected.to have_many :follows}
    it {is_expected.to have_many :categories}
    it {is_expected.to have_many :books}
    it {is_expected.to have_many :likes}
    it {is_expected.to have_many :comments}
  end

  describe "scope" do
    before :each do
      @user1 = User.create(name: "vuvanquy", email: "vuvanquy123@gmail.com",
        password: "password", password_confirmation: "password")
      @user2 = User.create(name: "vuvan", email: "vuvan123@gmail.com",
        password: "password", password_confirmation: "password")
      @user3 = User.create(name: "hoanghung", email: "hoanghung123@gmail.com",
        password: "password", password_confirmation: "password")
    end
    it "ordered by name asc" do
      expect(User.where.not(name: "admin").ordered_by_name).to eq [@user3, @user2, @user1]
    end
  end

  context "column" do
    it {is_expected.to have_db_column(:role_id).of_type(:integer)}
    it {is_expected.to have_db_index(:role_id)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:status).of_type(:boolean)}
    it {is_expected.to have_db_column(:password_digest).of_type(:string)}
    it {is_expected.to have_db_column(:remember_digest).of_type(:string)}
    it {is_expected.to have_db_column(:provider).of_type(:string)}
  end

  describe "#forget" do
    before {subject.forget}
    it "forget user" do
      expect(subject.remember_digest).to be_nil
    end
  end

  describe "#online" do
    before {subject.online}
    it "online status" do
      expect(subject.status).to be_truthy
    end
  end

  describe "#offline" do
    before {subject.offline}
    it "offline status" do
      expect(subject.status).to be_falsey
    end
  end

  describe "#downcase_email" do
    before :each do
      subject.email = "ADMIN123@GMAIL.COM"
    end
    it "downcase email of user before save" do
      expect(subject.send(:downcase_email)).to eq("admin123@gmail.com")
    end
  end
end
