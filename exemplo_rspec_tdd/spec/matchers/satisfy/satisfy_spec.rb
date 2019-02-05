describe 'satisfy' do
  it { expect(10).to satisfy {|number| number % 2 == 0} }
  it {
    expect(9).to satisfy('be a multiply of 3') do |number|
      number % 3 == 0
    end
  }
end
