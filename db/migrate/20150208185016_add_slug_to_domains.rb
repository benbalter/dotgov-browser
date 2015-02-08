class AddSlugToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :slug, :string
    add_index :domains, :slug, unique: true
  end
end
