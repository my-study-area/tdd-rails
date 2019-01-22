require 'string_nao_vazia'

describe 'Classes' do
  it 'be_instance_of' do
    expect(10).to be_instance_of(Integer) #classe exata
  end

  it 'be_kind_of' do
    str = StringNaoVazia.new
    expect(10).to be_kind_of(Integer)
    expect(str).to be_kind_of(StringNaoVazia) #pode ser herdada
  end

  it 'be_a/be_an' do
    str = StringNaoVazia.new
    expect(10).to be_an(Integer)
    expect(str).to be_an(StringNaoVazia)

    expect(10).to be_a(Integer)
    expect(str).to be_a(StringNaoVazia)
  end

  it 'respond_to' do
    expect("ruby").to respond_to(:size)
    expect("ruby").to respond_to(:count)
  end

end
