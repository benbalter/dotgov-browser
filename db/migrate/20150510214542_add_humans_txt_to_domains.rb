class AddHumansTxtToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :humans_txt, :boolean
    add_index :domains, :humans_txt
  end
end
