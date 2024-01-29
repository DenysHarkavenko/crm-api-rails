require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "devise modules" do
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
  end

  describe "acts_as_token_authenticatable" do
    it { should have_db_column(:authentication_token).of_type(:string).with_options(limit: 30) }
    it { should have_db_index(:authentication_token).unique(true) }
  end
end

