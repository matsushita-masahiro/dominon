class CreateMatchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :match_results do |t|
      t.references :match_inning
      t.integer :point
      t.references :user
      t.timestamps
    end
  end
end
