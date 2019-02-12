describe 'Matchers de comparação' do
  it '>' do
    expect(5).to be > 1
  end

  it '>=' do
    expect(5).to be >= 2
    expect(5).to be >= 5
  end

  it '<' do
    expect(5).to be < 6
  end

  it '<=' do
    expect(5).to be <= 6
    expect(5).to be <= 5
  end

  it 'be_between inclusive' do
    expect(5).to be_between(2,7).inclusive
    expect(2).to be_between(2,7).inclusive
    expect(7).to be_between(2,7).inclusive
  end

  # it 'be_between inclusive / Falhas agregadas', :aggregate_failures do
  #   expect(5).to be_between(2,7).inclusive
  #   expect(1).to be_between(2,7).inclusive
  #   expect(8).to be_between(2,7).inclusive
  # end

  # it 'be_between inclusive / Falhas agregadas', aggregate_failures: true do
  #   expect(5).to be_between(2,7).inclusive
  #   expect(1).to be_between(2,7).inclusive
  #   expect(8).to be_between(2,7).inclusive
  # end

  # it 'be_between inclusive' do
  #   aggregate_failures do
  #     expect(5).to be_between(2,7).inclusive
  #     expect(2).to be_between(2,7).inclusive
  #     expect(7).to be_between(2,7).inclusive
  #   end
  # end

  it 'be_between inclusive / Falhas agregadas' do
    expect(5).to be_between(2,7).inclusive
    expect(1).to be_between(2,7).inclusive
    expect(8).to be_between(2,7).inclusive
  end

  it 'be_between exclusive' do
    expect(5).to be_between(2,7).exclusive
    expect(3).to be_between(2,7).exclusive
    expect(6).to be_between(2,7).exclusive
  end

  it 'match' do
    expect('fulano@email.com').to match(/..@../)
  end

  it 'start_with' do
    expect('fulano@email.com').to start_with('fulano')
  end

  it 'end_with' do
    expect('fulano@email.com').to end_with('com')
  end

end
