require 'rails_helper'

describe Destination do
  describe '#create_destination' do
    it "is valid with a destination_family_name, destination_first_name, destination_kana_family_name, destination_kana_family_name, post_code, prefecture_id, municipality, house_number, building_name, phone_bumber" do
      destination = build(:destination)
      expect(destination).to be_valid
    end

    it "is invalid without a building_name" do
      destination = build(:destination, building_name: nil)
      expect(destination).to be_valid
    end

    it "is invalid without a phone_number" do
      destination = build(:destination, phone_number: nil)
      expect(destination).to be_valid
    end

    it "is invalid without a destination_family_name" do
      destination = build(:destination, destination_family_name: nil)
      destination.valid?
      expect(destination.errors[:destination_family_name]).to include("can't be blank")
    end

    it "is invalid without a destination_first_name" do
      destination = build(:destination, destination_first_name: nil)
      destination.valid?
      expect(destination.errors[:destination_first_name]).to include("can't be blank")
    end

    it "is invalid without a destination_kana_family_name" do
      destination = build(:destination, destination_kana_family_name: nil)
      destination.valid?
      expect(destination.errors[:destination_kana_family_name]).to include("can't be blank")
    end

    it "is invalid without a destination_kana_first_name" do
      destination = build(:destination, destination_kana_first_name: nil)
      destination.valid?
      expect(destination.errors[:destination_kana_first_name]).to include("can't be blank")
    end

    it "is invalid without a post_code" do
      destination = build(:destination, post_code: nil)
      destination.valid?
      expect(destination.errors[:post_code]).to include("can't be blank")
    end

    it "is invalid without a prefecture_id" do
      destination = build(:destination, prefecture_id: nil)
      binding.pry
      destination.valid?
      expect(destination.errors[:prefecture_id]).to include("can't be blank")
    end

    it "is invalid without a municipality" do
      destination = build(:destination, municipality: nil)
      destination.valid?
      expect(destination.errors[:municipality]).to include("can't be blank")
    end

    it "is invalid without a house_number" do
      destination = build(:destination, house_number: nil)
      destination.valid?
      expect(destination.errors[:house_number]).to include("can't be blank")
    end
  end
end