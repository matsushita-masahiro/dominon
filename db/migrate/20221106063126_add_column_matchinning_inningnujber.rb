class AddColumnMatchinningInningnujber < ActiveRecord::Migration[5.2]
  def change
    add_column :match_innings, :inning_number, :integer
  end
end
