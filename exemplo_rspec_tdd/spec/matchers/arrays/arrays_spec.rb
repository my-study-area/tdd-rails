RSpec::Matchers.define_negated_matcher :exclude, :include

describe Array.new([1,2,3]), "Array", :collection do
  it '#include' do
    expect(subject).to include(2)
    expect(subject).to include(2,1)
  end

  it { expect(subject).to exclude(4)}

  it '#contain_exactly', :slow do
    expect(subject).to contain_exactly(3,1,2)
  end

  it '#match_array', :slow do
    expect(subject).to match_array([2,3,1])
  end
end
