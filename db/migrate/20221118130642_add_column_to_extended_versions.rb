class AddColumnToExtendedVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :extended_versions, :omit_word, :string
  end
end
