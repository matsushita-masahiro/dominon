class AddColumnMatchUnitprice < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :unit_price, :integer
  end
end
