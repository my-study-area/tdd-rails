class AddSmokerFromCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :smoker, :string
  end
end
