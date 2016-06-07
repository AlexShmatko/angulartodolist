require 'rails_helper'

describe Task do

  it "has a valid factory" do
    expect(FactoryGirl.create(:task)).to be_valid
  end

  describe "validations" do
    it {should validate_presence_of(:title).on(:create)}
    it {should validate_length_of(:title).on(:create)}
  end
end
