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
end
