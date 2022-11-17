class CreateMatchInnings < ActiveRecord::Migration[5.2]
  def change
    create_table :match_innings do |t|
      t.references :match
      t.string :version_used
      t.timestamps
    end
  end
end
