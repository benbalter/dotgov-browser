class AddNameToJavascriptLibraries < ActiveRecord::Migration
  def change
    add_column :javascript_libraries, :name, :string
  end
end
