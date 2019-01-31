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
