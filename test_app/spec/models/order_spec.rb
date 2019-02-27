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
end
