# This migration comes from hyrax (originally 20170810190549)
class UpdateCollectionTypeColumnOptions < ActiveRecord::Migration[5.0]
  def change
    change_column :hyrax_collection_types, :title, :string, unique: true
    change_column :hyrax_collection_types, :machine_id, :string, unique: true

    remove_index :hyrax_collection_types, :machine_id
    add_index :hyrax_collection_types, :machine_id, unique: true
  end
end
