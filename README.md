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
## 48. Configurando Rspec no Rails
- `rails _5.1.4_ new test_app -T`: cria um projeto rails. A opção `-T` não cria a pasta padrão de testes do Rails
- adicione no arquivo `Gemfile`, dento do bloco `group :development, :test` o seguinte conteúdo:
  ```rb
  gem 'rspec-rails', '~> 3.6'
  ```
- execute `bundle install`
- verifique a configuração do arquivo `config/database.yml`
- crie os bancos de dados com `rails db:create:all`
- instale o rspce no projeto: `rails generate rspec install`
- adicione no final do seu arquivo **.rspec**: `--format documentation`
- instale o binário do `rspec`:
  - adicione no arquivo `Gemfile`, em `group :development` o seguinte:
    ```rb
    gem 'spring-commands-rspec'
    ```
  - instale as dependências: `bundle install`
  - execute: 
    ```rb
    bundle exec spring binstub rspec
    bundle exec spring binstub --all
    ```
  - para testar execute:
      ```sh
    bundle exec rspec
    bin/rspec
    ```
- configure o generator do rails para criar os testes do rspec adicionando o seguinte no arquivo `config/application.rb`, abaixo de `config.generators.system_tests = nil`:
  ```rb
      config.generators do |g|
        g.test_framework :rspec,
          fixtures: false,
          view_specs: false,
          helper_specs: false,
          routing_specs: false
      end
  ```
  - adicione a no arquivo `Gemfile`, dentro do grupo de test e developement o seguinte:
  ```sh
    gem 'capybara'
  ```
  - atualize as dependências: `bundle install`
# Factory Girl/Bot e VCR
## 49. Começando com fixtures
- crie o arquivo `spec/fixtures/customers.yml`:
```rb
jackson:
  name: Jackson Pires
  email: jackson@pires.com.br

jose:
  name: José da Silva
  email: jose@jose.com
```
- exemplo de uso:
```rb
require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :all
  it 'Create a Customer' do
    customer = customers(:jackson)
    expect(customer.full_name).to eq("Sr. Jackson Pires")

  end
end

```
## 50. Conhecendo o FactoryGirl(FactoryBot)
- adicione nas dependências do grupo development e test:
  ```rb
  gem "factory_bot_rails"
  ```
- adicione em `spec/rails_helper.rb`:
  ```rb
  include FactoryBot::Syntax::Methods
  ```
- exemplo de uso:
  ```rb
  it 'Create a Customer with FactoryBot' do
    customer = create(:customer)
    expect(customer.full_name).to eq("Sr. Jackson Pires")
  end
  ```
## 51. Gem Faker
- adicione nas dependências do grupo development e test:
  ```rb
  gem "fake"
  ```
- altere o arquivo `spec/factories/customer.rb`:
  ```rb
  FactoryBot.define do
    factory :customer do
      name {Faker::Name.name}
      email {Faker::Internet.email}
    end
  end
  ```
- exemplo de teste:
  ```rb
  it 'Create a Customer with FactoryBot' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr.")
  end

  it { expect{create(:customer)}.to change{Customer.all.size}.by(1) }
  ```
## 52. Sobrescrevendo atributos e Aliases para fábricas
- exemplo de sobrescrita de atributo:
  ```rb
  it 'Overwrites attributes with FactoryBot' do
    customer = create(:customer, name: 'Jackson Pires')
    expect(customer.full_name).to eq("Sr. Jackson Pires")
  end
  ```
- alias para fábrica:
  - altere o arquivo `spec/factories/customer.rb`:
    ```rb
    FactoryBot.define do
      factory :customer, aliases: [:user] do
        name {Faker::Name.name}
        email {Faker::Internet.email}
      end
    end
    ```
  - exemplo de uso:
    ```rb
    it 'FactoryBot with alias' do
      customer = create(:user)
      expect(customer.full_name).to start_with("Sr.")
    end
    ```
## 53. Herança
- exemplo de fábrica usando herança:
```rb
FactoryBot.define do
  factory :customer, aliases: [:user] do
    name {Faker::Name.name}
    email {Faker::Internet.email}

    factory :customer_vip do
      vip {true}
      days_to_pay {30}
    end

    factory :customer_default do
      vip {false}
      days_to_pay {15}
    end
  end
end
```
- exemplo de uso:
```rb
  it 'Herança com customer_vip' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'Herança com customer_default' do
    customer = create(:customer_default)
    expect(customer.vip).to eq(false)
  end
```
## 54. Attributes For
```rb
  it 'usando attributes_for' do
    attrs = attributes_for(:customer)
    attrs1 = attributes_for(:customer_vip)
    attrs2 = attributes_for(:customer_default)
    puts attrs
    puts attrs1
    puts attrs2
  end

  it 'usando attributes_for 2' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with("Sr.")
  end
```
## 55. Atributo Transitório
```rb
FactoryBot.define do
  factory :customer, aliases: [:user] do

    transient do
      upcased {false}
    end

    name {Faker::Name.name}
    email {Faker::Internet.email}

    factory :customer_vip do
      vip {true}
      days_to_pay {30}
    end

    factory :customer_default do
      vip {false}
      days_to_pay {15}
    end

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end
```
```rb
  it 'Atributo transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end
```
## 56. Traits
```rb
FactoryBot.define do
  factory :customer, aliases: [:user] do

    transient do
      upcased {false}
    end

    name {Faker::Name.name}
    email {Faker::Internet.email}

    trait :male do
      gender {'M'}
    end

    trait :female do
      gender {'F'}
    end

    trait :vip do
      vip {true}
      days_to_pay {30}
    end

    trait :default do
      vip {false}
      days_to_pay {15}
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_default, traits: [:default]
    factory :customer_male_vip, traits: [:male, :vip]
    factory :customer_female_vip, traits: [:female, :vip]
    factory :customer_male_default, traits: [:male, :default]
    factory :customer_female_default, traits: [:female, :default]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end
```
- exemplo de uso:
```rb
it 'Cliente Feminino' do
  customer = create(:customer_female)
  expect(customer.gender).to eq('F')
end

  it 'Cliente Feminino Default' do
  customer = create(:customer_female_default)
  expect(customer.gender).to eq('F')
end

  it 'Cliente Masculino Vip' do
  customer = create(:customer_male_vip)
  expect(customer.gender).to eq('M')
  expect(customer.vip).to eq(true)
end 
```
## 57. Callbacks
- [link da documentação falando sobre callbacks](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#callbacks)
## 58. Atributos dinâmicos
- [https://github.com/jacksonpires/rails-tdd/commit/5fea6f18db3979385875c87ae07524100be3ad20](https://github.com/jacksonpires/rails-tdd/commit/5fea6f18db3979385875c87ae07524100be3ad20)
## 59. Sequences
- [documentação sobre sequences](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#sequences)
- [exemplo de uso de sequences](https://github.com/jacksonpires/rails-tdd/commit/f376c427c218f6ea39dadfc2a269826c80600f47)

## 60. Associações (belong_to)
- arquivo de factory:
```rb
FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedio número - #{n}"}
    customer #form one
    # association :customer, factory: :customer #form two
  end
end
```
- arquivo de teste:
```rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 1 pedido com sobrescrita' do
    customer = create(:customer)
    order = create(:order, customer: customer)
    expect(order.customer).to be_kind_of(Customer)
  end
end
```
## 61. Create List
```rb
it 'Tem 3 pedidos usando create_list com três' do
  orders = create_list(:order, 3)
  expect(orders.count).to eq(3)
end

it 'Tem 3 pedidos usando sobrescrita de atributos' do
  orders = create_list(:order, 3, description: 'Testeee')
  p orders
  expect(orders.count).to eq(3)
end
```
## 62. Associações (has_many)
- exemplo: [https://github.com/jacksonpires/rails-tdd/commit/d11bbdfd9dd2f86f242bf438c943bea1082da099](https://github.com/jacksonpires/rails-tdd/commit/d11bbdfd9dd2f86f242bf438c943bea1082da099)
## 63. Métodos extras
- create_pair:
```rb
it 'Tem 2 pedidos usando create_pair' do
  orders = create_pair(:order)
  expect(orders.count).to eq(2)
end
```
- build_pair
- attributes_for_list
- build_stubbed
- build_stubbed_list
## 64. FactoryBot Lint
- exibe os erros de forma mais clara. Por exemplo quando adicoinamos uma coluna chamada address como obrigatório e não mudamos os testes
- adicione o seguinte dento do arquivo `spec/spec_helper.rb`:
```rb
#FactoryBot Lint
config.before(:suite) do
  FactoryBot.lint
end
```
## 65. HTTParty
- [httparty](https://github.com/jnunemaker/httparty)
- [api para teste](https://jsonplaceholder.typicode.com/)
- adicione a gem no grupo desenvolvimento e teste: `  gem 'httparty'`
```rb
describe 'HTTParty' do
  it 'HTTParty' do
    response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end
end
```
## 66. Webmock
- adicione no Gemfile: ` gem 'webmock'`
- adicione no `spec/spec_helper.rb`: `require 'webmock/rspec'`
- exemplo de uso:
```rb
it 'content-type' do
  stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
        to_return(status: 200, body: "", headers: { 'content-type': 'application/json'})

  response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
  content_type = response.headers['content-type']
  expect(content_type).to match(/application\/json/)
end
```
- [commit com as alterações](https://github.com/jacksonpires/rails-tdd/commit/ecc3db8f59ce4f9e59a8140d7d3f534d1e6b8b12)
## 67. VCR
- adicione a gem: `gem 'vcr'`
- adicione no `spec/spec_helper.rb`:
```rb
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
```
- exemplo de uso no teste:
```rb
  it 'content-type' do
    VCR.use_cassette("jsonplaceholder/posts") do
      response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
    end
  end
```
- [commit com as alterações](https://github.com/jacksonpires/rails-tdd/commit/675787a579dfea2923a38718ed01d7662972338e)
## 68. VCR com metadados RSpec
- atualize a configuração do VCR no `spec/spec_helper.rb` como o exemplo abaixo:
```rb
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
```
- exemplo de teste:
```rb
it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts'} do
  #stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
  #     to_return(status: 200, body: "", headers: { 'content-type': 'application/json'})

  response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
  content_type = response.headers['content-type']
  expect(content_type).to match(/application\/json/)
end
```
- [commit com as alterações](https://github.com/jacksonpires/rails-tdd/commit/7ee47d9c7a71bff05e172f501ac49bf2ffd9587d)

## 69. VCR (filtrando dados sensíveis)
- adicone na configuração do VCR em `spec/spec_helper.rb
`: ***config.filter_sensitive_data('<API-URL>') { 'https://jsonplaceholder.typicode.com' }***
- exemplo completo:
```rb
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<API-URL>') { 'https://jsonplaceholder.typicode.com' }
end
```
## 70. VCR com URIs não determinísticas
- exemplo de configuração:
```rb
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body]} do
    #stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #     to_return(status: 200, body: "", headers: { 'content-type': 'application/json'})

    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{[1,2,3,4,5].sample}")
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end
```
## 71. Modos de gravação do VCR
- exemplo de VCR criando um novo cassete para cada lateração de URI:
```rb
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', :record => :new_episodes } do
     response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{[1,2,3,4,5].sample}")	    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/3")
    content_type = response.headers['content-type']	    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)	    expect(content_type).to match(/application\/json/)
  end
```
