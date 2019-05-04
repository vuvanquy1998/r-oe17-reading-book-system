require "rails_helper"
RSpec.describe Writer, type: :model do
  context "associations" do
    it {is_expected.to belong_to :author}
    it {is_expected.to belong_to :book}
  end

  context "columns" do
    it {is_expected.to have_db_column(:author_id).of_type(:integer)}
    it {is_expected.to have_db_column(:book_id).of_type(:integer)}
    it {is_expected.to have_db_index(:author_id)}
    it {is_expected.to have_db_index(:book_id)}
  end
end
