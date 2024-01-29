require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'belongs to the project' do
    expect(Task.reflect_on_association(:project).macro).to eq :belongs_to
  end
end
