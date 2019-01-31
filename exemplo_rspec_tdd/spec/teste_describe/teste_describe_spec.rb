RSpec.describe 'Teste de describe' do
  it 'does something' do
  end

  describe 'adriano' do
    it 'String' do
      expect(subject.size).to eq(7)
    end
  end

  describe [0, 1] do
    it 'Array' do
      expect(subject).to be_kind_of(Array)
    end
  end
end
