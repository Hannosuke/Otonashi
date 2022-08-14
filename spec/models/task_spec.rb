require 'rails_helper'

describe Task do
  describe '#description' do
    let(:task) { build(:task, description: description) }

    before { task.validate }

    context 'nilのとき' do
      let(:description) { nil }

      it { expect(task).to be_invalid }
    end

    context '空文字のとき' do
      let(:description) { '' }

      it { expect(task).to be_invalid }
    end
  end
end
