require "rails_helper"
RSpec.describe Follow, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :category}
  end

  context "columns" do
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_index(:user_id)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
    it {is_expected.to have_db_index(:category_id)}
  end
end
