class CreateContentManagementSystems < ActiveRecord::Migration
  def change
    create_table :content_management_systems do |t|
      t.string :name

      t.timestamps null: false
    end

    change_table :domains do |t|
      t.belongs_to :content_management_system, index: true
    end
  end
end
