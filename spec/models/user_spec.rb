require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'Associations' do
    it { should have_many(:jobs).dependent(:destroy) }
    it { should have_many(:applications).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Validation' do
    it 'should not be valid if age under 18' do
      user = build(:user, age: 17)
      expect(user).to_not be_valid
    end

    it 'should not be valid if email is not in format' do
      user = build(:user, email: 'test.com')
      expect(user).to_not be_valid
    end
  end
  
  describe 'Factory' do
    it 'has a valid factory' do
      user = create(:user)
      expect(user).to be_valid
    end
  end
end