class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :match,  null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps 
    end
  end
end
