require 'pessoa'

describe 'Atributos' do

  # before(:context) do
  #    puts ">>>>>>>>>> ANTES de TODOS os testes"
  #  end
  #
  #  after(:all) do
  #    puts ">>>>>>>>>> DEPOIS de TODOS os testes"
  #  end

  # before(:each) do
  #   puts "ANTES"
  #   @pessoa = Pessoa.new
  # end
  #
  # after(:each) do
  #  @pessoa.nome = "Sem nome!"
  #  puts "DEPOIS >>>>>>> #{@pessoa.inspect}"
  # end

  # around(:each) do |teste|
  #  puts "ANTES"
  #  @pessoa = Pessoa.new
  #
  #  teste.run # roda o teste
  #
  #  @pessoa.nome = "Sem nome!"
  #  puts "DEPOIS >>>>>>> #{@pessoa.inspect}"
  # end

  let(:pessoa) { Pessoa.new}

  it 'have_attributes' do
    pessoa.nome = "Adriano"
    pessoa.idade = 34
    expect(pessoa).to have_attributes(nome: "Adriano", idade: 34)
    expect(pessoa).to have_attributes(nome: "Adriano", idade: (be >= 20))
    expect(pessoa).to have_attributes(nome: starting_with("A"), idade: (be >= 20))
  end

  it 'have_attributes' do
    pessoa.nome = "Augusto"
    pessoa.idade = 30
    expect(pessoa).to have_attributes(nome: starting_with("A"), idade: (be >= 20))
  end
end
