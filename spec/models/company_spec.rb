require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
  end

  describe "Associations" do
    it { should have_many(:jobs).dependent(:destroy) }
  end

  describe "Factory" do
    it "has a valid factory" do
      company = create(:company)
      expect(company).to be_valid
    end
  end
end
