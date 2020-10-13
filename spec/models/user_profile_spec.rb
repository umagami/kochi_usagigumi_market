require 'rails_helper'

describe UserProfile do
  describe '#create_user_profile' do
    it "is valid with a family_name, first_name, kana_family_name, kana_first_name, birthday" do
      user_profile = build(:user_profile)
      expect(user_profile).to be_valid
    end

    it "is invalid without a family_name" do
      user_profile = build(:user_profile, family_name: nil)
      user_profile.valid?
      expect(user_profile.errors[:family_name]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      user_profile = build(:user_profile, first_name: nil)
      user_profile.valid?
      expect(user_profile.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a kana_family_name" do
      user_profile = build(:user_profile, kana_family_name: nil)
      user_profile.valid?
      expect(user_profile.errors[:kana_family_name]).to include("can't be blank")
    end

    it "is invalid without a kana_first_name" do
      user_profile = build(:user_profile, kana_first_name: nil)
      user_profile.valid?
      expect(user_profile.errors[:kana_first_name]).to include("can't be blank")
    end

    it "is invalid without a birthday" do
      user_profile = build(:user_profile, birthday: nil)
      user_profile.valid?
      expect(user_profile.errors[:birthday]).to include("can't be blank")
    end

    it 'If family_name is not full size input, cannot register it' do
      user_profile = build(:user_profile, family_name: "ｱｲｳｴｵ")
      user_profile.valid?
      expect(user_profile.errors[:family_name]).to include("全角で入力してください")
    end

    it 'If first_name is not full size input, cannot register it' do
      user_profile = build(:user_profile, first_name: "ｱｲｳｴｵ") 
      user_profile.valid?
      expect(user_profile.errors[:first_name]).to include("全角で入力してください")
    end

    it 'If kana_family_name is not full size katakana, cannot register it' do
      user_profile = build(:user_profile, kana_family_name: "あいうえお")
      user_profile.valid?
      expect(user_profile.errors[:kana_family_name]).to include("全角(カナ)で入力してください")
    end

    it 'If kana_first_name is not full size katakana, cannot register it' do
      user_profile = build(:user_profile, kana_first_name: "あいうえお")
      user_profile.valid?
      expect(user_profile.errors[:kana_first_name]).to include("全角(カナ)で入力してください")
    end
  end
end