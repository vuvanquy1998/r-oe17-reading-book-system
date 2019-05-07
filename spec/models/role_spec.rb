require "rails_helper"
RSpec.describe Role, type: :model do
  context "associations" do
    it {is_expected.to have_many :users}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
  end
end
