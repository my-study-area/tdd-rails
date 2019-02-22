require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :all
  it 'Create a Customer' do
    customer = customers(:jackson)
    expect(customer.full_name).to eq("Sr. Jackson Pires")
  end

  it 'Overwrites attributes with FactoryBot' do
    customer = create(:customer, name: 'Jackson Pires')
    expect(customer.full_name).to eq("Sr. Jackson Pires")
  end

  it 'FactoryBot with alias' do
    customer = create(:user)
    expect(customer.full_name).to start_with("Sr.")
  end

  it 'Herança com customer_vip' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'Herança com customer_default' do
    customer = create(:customer_default)
    expect(customer.vip).to eq(false)
  end

  it 'Create a Customer with FactoryBot' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr.")
  end

  it { expect{create(:customer)}.to change{Customer.all.size}.by(1) }


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

  it 'Atributo transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

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
end
