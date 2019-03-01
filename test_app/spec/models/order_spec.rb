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

  it 'Tem 3 pedidos usando create_list com três' do
    orders = create_list(:order, 3)
    expect(orders.count).to eq(3)
  end

  it 'Tem 3 pedidos usando sobrescrita de atributos' do
    orders = create_list(:order, 3, description: 'Testeee')
    p orders
    expect(orders.count).to eq(3)
  end

  it 'has_many' do
    customer = create(:customer, :with_orders)
    expect(customer.orders.count).to eq(3)
  end

  it 'has_many com sobrescrita' do
    customer = create(:customer, :with_orders, qtt_orders: 5)
    expect(customer.orders.count).to eq(5)
  end

  it 'Tem 2 pedidos usando create_pair' do
    orders = create_pair(:order)
    expect(orders.count).to eq(2)
  end
end
