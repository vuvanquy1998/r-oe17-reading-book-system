require "rails_helper"
RSpec.describe Chapter, type: :model do
  context "associations" do
    it {is_expected.to belong_to :book}
  end

  describe "validation" do
    context "name" do
      it {is_expected.to validate_presence_of :name}
    end
    context "content" do
      it {is_expected.to validate_presence_of :content}
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:book_id).of_type(:integer)}
    it {is_expected.to have_db_index(:book_id)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:content).of_type(:text)}
  end
end
