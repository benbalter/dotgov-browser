class CreateJavascriptLibraries < ActiveRecord::Migration
  def change
    create_table :javascript_libraries do |t|
      t.timestamps null: false
    end

    change_table :domains do |t|
      t.belongs_to :javascript_library, index: true
    end
  end
end
