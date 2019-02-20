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

  it 'Create a Customer with FactoryBot' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr.")
  end

  it { expect{create(:customer)}.to change{Customer.all.size}.by(1) }
end
