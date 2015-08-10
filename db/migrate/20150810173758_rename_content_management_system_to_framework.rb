class RenameContentManagementSystemToFramework < ActiveRecord::Migration
  def change
    rename_table :content_management_systems, :frameworks
    rename_column :domains, :content_management_system_id, :framework_id
  end
end
