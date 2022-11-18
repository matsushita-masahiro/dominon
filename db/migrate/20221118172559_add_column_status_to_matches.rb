class AddColumnStatusToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :match_end, :boolean, default: false, null: false
  end
end
