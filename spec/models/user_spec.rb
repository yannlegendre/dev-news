require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    user_one = User.new(email: 'toto@gmail.com',
                        password: 'tototo')
    user_two = User.new(email: 'tata@gmail.com',
                        password: 'tatata')
    user_three = User.new(email: 'toto@toto', password:'123')
    user_four = User.new(email: 'toto@gmail.com', password:'azertyuiop')
    it "valid users should be persisted in db" do
      user_one.save
      user_two.save
      expect(User.count).to eq(2)
    end
    it "should allow two users to have the same password" do
      expect(User.create(email: 'michel@coucou.fr',
                         password: 'tototo')).to be_truthy
    end
    it "should reject passwords less than 6 characters" do
      expect(user_three.valid?).to be false
    end
    it "should reject sign in with email already taken" do
      user_one.save
      expect(user_four.valid?).to be false
    end
  end
end
