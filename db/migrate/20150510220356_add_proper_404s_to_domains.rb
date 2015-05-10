class AddProper404sToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :proper_404s, :boolean
    add_index :domains, :proper_404s
  end
end
