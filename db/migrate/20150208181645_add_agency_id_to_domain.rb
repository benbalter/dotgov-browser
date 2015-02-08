class AddAgencyIdToDomain < ActiveRecord::Migration
  def change
    change_table :domains do |t|
      t.belongs_to :agency, index: true
    end
  end
end
