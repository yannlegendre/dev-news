require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end
  context 'Validations' do
    user_one = User.new(email: 'toto@gmail.com',
                        password: 'tototo')
    user_two = User.new(email: 'tata@gmail.com',
                        password: 'tatata')
    user_three = User.new(email: 'toto@toto', password:'123')
    user_four = User.new(email: 'toto@gmail.com', password:'azertyuiop')
    it "valid users should be persisted in db" do
      user_one.save
      user_two.save
      expect(User.count).to eq(3)
    end
    it "should allow two users to have the same password" do
      expect(User.create(email: 'michel@coucou.fr',
                         password: 'tototo')).to be_valid
    end
    it "should reject passwords less than 6 characters" do
      expect(user_three.valid?).to be false
    end
    it "should reject sign in with email already taken" do
      user_one.save
      expect(user_four.valid?).to be false
    end
  end

  context 'Associations' do
    it "has many comments" do
      expect(@user.comments).to be_truthy
    end
    it "has many upvotes" do
      expect(@user.upvotes).to be_truthy
    end
  end
end
