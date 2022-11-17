class AddColumnToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :place, :string
    add_column :matches, :start_time, :time
    add_column :matches, :end_time, :time
    add_column :matches, :held_date, :date

  end
end
