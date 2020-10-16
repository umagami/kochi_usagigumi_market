require 'rails_helper'

describe Card do
  describe '#create' do
    it "is valid with a customer_token, user_id" do
      card = build(:card)
      expect(card).to be_valid
    end

    it "is invalid without a customer_token" do
      user = create(:user)
      card = build(:card, customer_token: nil, user_id: user.id)
      card.valid?
      expect(card.errors[:customer_token]).to include("can't be blank")
    end
    
    it "is invalid without a user_id" do
      card = build(:card)
      card.user = nil
      card.valid?
      expect(card.errors[:user]).to include("must exist")
    end
  end
end