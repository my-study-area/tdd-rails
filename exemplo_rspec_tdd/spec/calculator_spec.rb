require 'calculator'

describe Calculator do
subject(:calc) { described_class.new }

  context '#sum' do
    it 'with positives numbers' do
      result = calc.sum(5,7)
      expect(result).to eq(12)
    end
    it 'with positive and negative numbers' do
      result = calc.sum(-5,7)
      expect(result).to eq(2)
    end
    it 'with negative numbers' do
      result = calc.sum(-5,7)
      expect(result).to eq(2)
    end
  end
end
