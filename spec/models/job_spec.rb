require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:salary) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
    it { should have_many(:applications).dependent(:destroy) }
  end

  describe 'Factory' do
    it 'has a valid factory' do
      user = create(:user)
      company = create(:company)
      job = create(:job, user: user, company: company)
      expect(job).to be_valid
    end
  end
end
