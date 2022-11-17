class CreateExtendedVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :extended_versions do |t|
      t.string :name
      t.timestamps
    end
  end
end
