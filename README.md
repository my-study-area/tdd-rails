# TDD com Ruby on Rails, RSpec e Capybara
Esse repositório contém as informações referentes ao [Curso TDD com Ruby on Rails, RSpec e Capybara](https://www.udemy.com/rails-tdd/) do professor [Jackson Pires](https://about.me/jacksonpires)

O repositório oficial do curso está disponível em [https://github.com/jacksonpires/rails-tdd](https://github.com/jacksonpires/rails-tdd)


## 5. Conhecendo o RSpec
- `gem instal` # instala o Rspec
- `rspec --init` #inicia um projeto Rspec
- `gem install bundler` # instala o gerenciador de dependências do ruby
- `bundle install` - instala as dependências

## 8. Exercitando o TDD com Rspec (Parte 2/2)
- should Vs expect: [RSpec's New Expectation Syntax](http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/)
- [Better Specs](http://www.betterspecs.org/)

## 9. Teste em 4 Fases
Um teste do padrão xUnit tem quatro fases, são elas:
- Setup: Quando você coloca o SUT (system
under test, o objeto sendo testado) no estado
necessário para o teste;
- Exercise: Quando você interage com o SUT;
- Verify: Quando você verifica o comportamento
esperado;
- Teardown: Quando você coloca o sistema no
estado em que ele estava antes do teste ser
executado.

## 11. Context e .rspec
- `rspec --format documentation` - executa os testes exibindos as descrições dos teste de forma mais completa
- adicione `rspec --format documentation` no arquivo `.rspec` para executar somente com `rspec`

## 13. It, xit, e outras coisas
- `it 'with negative numbers'` (it sem o corpo) : executa o teste marcando como pendente
- `xit`: executa o teste marcando como pendente
    ```ruby
    it 'with negative numbers' do
      result = subject.sum(-5,7)
      expect(result).to eq(2)
    end
    ```
- `rspec -e 'with negative numbers'`: executa somente o teste com o  `it 'with negative numbers'`
- `rspec ./spec/calculator_spec.rb:13`: executa somente o teste da linha 13

## 16. Matchers de Igualdade
- `equal/be`: verifica se ops objetos são iguais
- `eql/eq`: verifica se os valores são iguais

## 20. Matchers para atributos de Classes

- [Listas de aliases metachers](https://gist.github.com/JunichiIto/f603d3fbfcf99b914f86)

## 22. Matchers de Erros
Exemplos com divisão por zero:
- expect{3 / 0}.to raise_exception # com warning
- expect{3 / 0}.to raise_error #com warning
- expect{3 / 0}.to raise_error(ZeroDivisionError)
- expect{3 / 0}.to raise_error("divided by 0")
- expect{3 / 0}.to raise_error(ZeroDivisionError, "divided by 0")
- expect{3 / 0}.to raise_error(/divided/)

## 24. Matchers para Arrays
- expect(subject).to include(2)
- expect(subject).to include(2,1)
- expect(subject).to contain_exactly(3,1,2)
- expect(subject).to match_array([2,3,1])

## 25. Matchers para Ranges
```rb
describe (1..5), 'Ranges' do
  it '#cover' do
    expect(subject).to cover(2)
    expect(subject).to cover(5)
  end
end
```

## 26. One-liner Syntax (Subject)
```rb
  it { is_expected.to cover(2) }
  it { is_expected.to cover(2,5) }
  it { is_expected.not_to cover(0,6) }
```
## 27. Composição de Expectativas
```rb
  it { is_expected.to start_with('Ruby').and end_with('Rails') }
  it { expect(fruta).to eq('banana').or eq('laranja').or eq('uva')}

  def fruta
    %w(banana laranja uva).sample
  end
```
## 28. Matchers para Coleções
```rb
  it { expect([1,5,9]).to all((be_odd).and (be_an(Integer))) }
  it { expect(['ruby', 'rails']).to all(be_a(String).and include('r')) }
```
## 29. Matcher be_within
```rb
describe 'be_within' do
  it { expect(12.5).to be_within(0.5).of(12) }
  it { expect([12.5,12.1,12.4]).to all (be_within(0.5).of(12)) }
end
```
## 30. Matcher satisfy
```rb
  it { expect(10).to satisfy {|number| number % 2 == 0} }
  it {
    expect(9).to satisfy('be a multiply of 3') do |number|
      number % 3 == 0
    end
  }
```
## 31. Helper Methods (Arbitrários e de Módulo)
- Helper Arbitrário:
```rb
describe 'Ruby on Rails' do
  it { is_expected.to start_with('Ruby').and end_with('Rails') }
  it { expect(fruta).to eq('banana').or eq('laranja').or eq('uva')}

  def fruta
    %w(banana laranja uva).sample
  end
end
```
- Helper de Módulo:
    - Adicione `require_relative '../helpers/helper'` no início do arquivo `exemplo_rspec_tdd/spec/spec_helper.rb` e adicione `config.include Helper` dentro de `RSpec.configure do |config|`. Exemplo:
    ```rb
    require_relative '../helpers/helper'

    RSpec.configure do |config|

      # Helper Methods de Módulo
      config.include Helper
    
      # code ...
    end
    ```
## 32. Hooks (before e after)
Arquivo `exemplo_rspec_tdd/spec/spec_helper.rb`:
```rb
  config.before(:suite) do
    puts ">>>>>>>>>> ANTES de TODA a suíte de testes"
  end

  config.after(:suite) do
    puts ">>>>>>>>>> DEPOIS de TODA a suíte de testes"
  end

  config.before(:context) do
    puts ">>>>>>>>>> ANTES de TODOS os testes"
  end

  config.after(:all) do
    puts ">>>>>>>>>> DEPOIS de TODOS os testes"
  end
```
Dentro dos testes:
```rb
  before(:each) do
    puts "ANTES"
    @pessoa = Pessoa.new
  end

  after(:each) do
   @pessoa.nome = "Sem nome!"
   puts "DEPOIS >>>>>>> #{@pessoa.inspect}"
  end
```
## 33. Hooks (around)
```rb
  around(:each) do |teste|
   puts "ANTES"
   @pessoa = Pessoa.new

   teste.run # roda o teste

   @pessoa.nome = "Sem nome!"
   puts "DEPOIS >>>>>>> #{@pessoa.inspect}"
  end
```
## 34. Helper Methods (let e let!)
`let`: a variável é carregada apenas
quando ela é utilizada pela primeira vez
no teste e fica na cache até o teste em
questão terminar.
```rb
$counter = 0

describe 'let' do
  let(:count) { $counter += 1 }

  it 'memoriza o valor' do
    expect(count).to eq(1)
    expect(count).to eq(1)
  end

  it 'não é cacheado entre os testes' do
    expect(count).to eq(2)
  end
end
```
`let!`: forçar a invocação do método/helper antes de cada teste
```rb
$count = 0

describe 'let!' do
  ordem_de_invocacao = []

  let!(:contador) do
    ordem_de_invocacao << :let!
    $count += 1
  end

  it 'chama o método helper antes do teste' do
    ordem_de_invocacao << :exemplo
    expect(ordem_de_invocacao).to eq([:let!, :exemplo])
    expect(contador).to eq(1)
  end
end
```

## 35. Matcher change
```rb
it { expect { Contador.incrementa }.to change {Contador.qtd} }
it { expect { Contador.incrementa }.to change  {Contador.qtd}.by(1) }
it { expect { Contador.incrementa }.to change  {Contador.qtd}.from(2).to(3) }
```
## 36. Matcher Output
```rb
it { expect { puts "adriano"}.to output.to_stdout }
it { expect { print "adriano" }.to output("adriano").to_stdout }
it { expect { puts "adriano avelino" }.to output(/adriano/).to_stdout }

it { expect { warn "adriano" }.to output.to_stderr }
it { expect { warn "adriano" }.to output("adriano\n").to_stderr }
it { expect { warn "adriano" }.to output(/adriano/).to_stderr }
```
## 37. Negativando Matchers
- Adicione `RSpec::Matchers.define_negated_matcher :<novo>, :<velho>` no início do arquivo e acrescente o teste abaixo:
```rb
RSpec::Matchers.define_negated_matcher :exclude, :include

describe Array.new([1,2,3]), "Array" do
  it '#include' do
    expect(subject).to include(2)
    expect(subject).to include(2,1)
  end
  it { expect(subject).to exclude(4)}
end

```
No exemplo acima ele se comporta da forma negativado `include`.

## 38. Agregando Falhas 
Por padrão os testes dentro it que possuem diversas expects param ao encontrar a primeira falha no expect. É nesses casos que podemos agregar as falhas, mostrando as demais expects com erro, caso possuam.
- Agregando falhas em bloco:
```rb
it 'be_between inclusive' do
  aggregate_failures do
    expect(5).to be_between(2,7).inclusive
    expect(2).to be_between(2,7).inclusive
    expect(7).to be_between(2,7).inclusive
  end
end
```
- Agregando falhas dentro do `it`:
```rb
it 'be_between inclusive / Falhas agregadas', :aggregate_failures do
  expect(5).to be_between(2,7).inclusive
  expect(1).to be_between(2,7).inclusive
  expect(8).to be_between(2,7).inclusive
end
```
- ou na forma antiga:
```rb
it 'be_between inclusive / Falhas agregadas', aggregate_failures: true do
  expect(5).to be_between(2,7).inclusive
  expect(1).to be_between(2,7).inclusive
  expect(8).to be_between(2,7).inclusive
end
```
- dentro do spec_helper:
```rb
#requires

RSpec.configure do |config|

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
  #codes

end
```
## 39. Shared Examples
- classe `pessoa.rb`
```rb
class Pessoa
  attr_reader :status

  def feliz!
    @status = "Sentindo-se Feliz!"
  end

  def triste!
    @status = "Sentindo-se Triste!"
  end

  def contente!
    @status = "Sentindo-se Contente!"
  end
end

```
- `shared_example`:
```rb
require 'pessoa'

shared_examples 'status' do |sentimento|
  it "#{sentimento}" do
    pessoa.send("#{sentimento}!")
    expect(pessoa.status).to eq("Sentindo-se #{sentimento.capitalize}!")
  end
end

describe 'Pessoa' do
  subject(:pessoa) { Pessoa.new }

  include_examples 'status', :feliz
  it_behaves_like 'status', :triste
  it_should_behave_like 'status', :contente

  # it 'feliz!' do
  #   pessoa.feliz!
  #   expect(pessoa.status).to eq('Sentindo-se Feliz!')
  # end
  #
  # it 'triste!' do
  #   pessoa.triste!
  #   expect(pessoa.status).to eq('Sentindo-se Triste!')
  # end
  #
  # it 'contente!' do
  #   pessoa.contente!
  #   expect(pessoa.status).to eq('Sentindo-se Contente!')
  # end
end
```
## 40. Customizando Matchers
- define um matcher customizado:
```rb
RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end
```
- define a mesagem de erro de matcher customizado:
```rb
  failure_message do |actual|
    "expected that #{actual} would be a multiple of #{expected}"
  end
```
- define a mesagem de sucesso do matcher customizado:
```rb
description do
  "be a multiple of #{expected}"
end
```
Exemplo completo com teste:
```rb
RSpec::Matchers.define :be_a_multiple_of do |expected|
  # expected == 3
  # actual == subject == 18

  #custom matcher
  match do |actual|
    actual % expected == 0
  end

  #custom failure message
  failure_message do |actual|
    "expected that #{actual} would be a multiple of #{expected}"
  end

  #custom success message
  description do
    "be a multiple of #{expected}"
  end
end

#test
describe 18, 'Custom Matcher' do
  it { is_expected.to be_a_multiple_of(3)}
end
```
## 41. Tag Filter
São usados para filtar alguns tipos de testes, como por exemplo collections, arrays e etc.    
Podemos colocar tag nos testes das seguintes formas:
- `tagname: true`:
```rb
describe 'all', collection: true do
  it { expect([1,7,9]).to all( (be_odd).and be_an(Integer) )}
end
```
Para testar executamos: `rspec . -t collection: true`

- `type: tagname`
```rb
describe 'all',  type: 'collection' do
  it { expect([1,5,9]).to all((be_odd).and (be_an(Integer))) }
end
```
Para testar executamos: `rspec . -t type:collection`
- ou com symbols:
```rb
describe 'all', :collection do
  it { expect([1,5,9]).to all((be_odd).and (be_an(Integer))) }
end
```
Para testar executamos: `rspec . -t collection`

Também podemos negar alguns testes. Exemplo:
```rb
it '#include' do
  expect(subject).to include(2)
  expect(subject).to include(2,1)
end
it '#contain_exactly', :slow do
  expect(subject).to contain_exactly(3,1,2)
end
```
Para testar executamos: `rspec . -t collection -t ~slow`

E caso seja necessário pode-se acrescentar no arquivo `.rspec`:
```rb
--tag type:collection
--tag ~slow
```
## 42. Test Double
```rb
describe 'Test Double' do
  it 'Double' do
    user = double('User')
    #resumido
    # allow(user).to receive_messages(name: 'Adriano', password: 'secret')
    
    # verboso
    allow(user).to receive(:name).and_return('Jack')
    allow(user).to receive(:password).and_return('secret')
    user.name
    user.password
  end
end
```
## 43. Stubs
```rb
describe 'Stub' do
  it '#has_finished?' do
    student = Student.new
    course = Course.new

    allow(student).to receive(:has_finished?)
      .with(an_instance_of(Course))
      .and_return(true)
    course_finished = student.has_finished?(course)
    expect(course_finished).to be_truthy
  end
end
```
## 44. Method Stubs
- argumento dinâmico:
```rb
  it 'Argumentos Dinâmicos' do
    student = Student.new

    allow(student).to receive(:foo) do |arg|
      if arg == :hello
        "olá"
      elsif arg == :hi
        "Hi!!!"
      end
    end

    expect(student.foo(:hello)).to eq('olá')
    expect(student.foo(:hi)).to eq('Hi!!!')
```
- Qualquer instância de Classe:
```rb
  it 'Qualquer instância de Classe' do
    student = Student.new
    other_student = Student.new

    allow_any_instance_of(Student).to receive(:bar).and_return(true)

    expect(student.bar).to be_truthy
    expect(other_student.bar).to be_truthy
  end
```
- Testando Erros:
```rb
it 'Erros' do
  student = Student.new

  allow(student).to receive(:bar).and_raise(RuntimeError)

  expect{ student.bar }.to raise_error(RuntimeError)
end
```
## 45. Mock
```rb
 describe 'Mocks' do
  it '#bar' do
    # setup
    student = Student.new

     # verify
    expect(student).to receive(:bar)

     # exercise
    student.bar
  end
end
```
## 46. Mock Expectation
- mock com restrição de argumento
```rb
it 'args' do
  student = Student.new
  expect(student).to receive(:foo).with(123)
  student.foo(123)
end
```
- mock com contagem de chamadas
```rb
it 'repetição' do
  student = Student.new
  expect(student).to receive(:foo).with(123).twice
  student.foo(123)
  student.foo(123)
end
```
- mock com valor de retorno
```rb
it 'retorno' do
  student = Student.new
  expect(student).to receive(:foo).with(123).and_return(true)
  puts student.foo(true)
end
```
## 47. Método "As Null object"
```rb
it 'as_null_object' do
  user = double('User').as_null_object
  allow(user).to receive(:name).and_return('Jack')
  allow(user).to receive(:password).and_return('secret')
  puts user.name
  puts user.password
  user.abc
end
```
