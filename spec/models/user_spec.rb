require "rails_helper"

describe User do

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name).on(:create) }
    it { should validate_length_of(:first_name).on(:create) }
    it { should validate_presence_of(:last_name).on(:create) }
    it { should validate_length_of(:last_name).on(:create) }
    it { should validate_presence_of(:email).on(:create) }
    it { should validate_uniqueness_of(:email).on(:create) }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).on(:create) }
  end

  describe 'associations' do
    it { should have_many(:tasks) }
  end

  describe 'full name' do
    it "returns full name of user" do
      johns =  FactoryGirl.build(:user, first_name: 'David', last_name:'Johns')
      expect(johns.full_name).to eq("David Johns")
    end

    it "returns first name when last name is blank" do
      johns = FactoryGirl.build(:user, first_name: "David", last_name: nil, email: 'eugene@active-bridge.com', password: '12345678')
      expect(johns.full_name).to eq("David")
    end

    it "returns last name with blank first name" do
      johns = FactoryGirl.build(:user, first_name: nil, last_name: "Johns", email: 'eugene@active-bridge.com', password: '12345678')
      expect(johns.full_name).to eq("Johns")
    end

    it "returns email" do
      johns = FactoryGirl.build(:user, first_name: nil, last_name: nil, email: 'eugene@active-bridge.com', password: '12345678')
      expect(johns.full_name).to eq("eugene@active-bridge.com")
    end
  end
end
