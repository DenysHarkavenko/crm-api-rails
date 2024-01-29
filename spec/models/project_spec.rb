require 'rails_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    project = FactoryBot.build(:project)
    expect(project).to be_valid
  end

  describe "associations" do
    it do
      should have_many(:tasks).dependent(:destroy)
    end
  end
end
