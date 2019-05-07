require "rails_helper"
RSpec.describe Category, type: :model do
  context "associations" do
    it {is_expected.to have_many :follows}
    it {is_expected.to have_many :users}
    it {is_expected.to have_many :books}
  end

  context "name" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_uniqueness_of :name}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
  end
end
