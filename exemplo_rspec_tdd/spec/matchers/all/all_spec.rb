describe 'all', :collection do
  it { expect([1,5,9]).to all((be_odd).and (be_an(Integer))) }
  it { expect(['ruby', 'rails']).to all(be_a(String).and include('r')) }
end
