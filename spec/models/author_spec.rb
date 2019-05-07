require "rails_helper"
RSpec.describe Author, type: :model do
  context "associations" do
    it {is_expected.to have_many :writers}
    it {is_expected.to have_many :books}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
  end
end
