class ConvertRedirectToBool < ActiveRecord::Migration
  def change
    remove_column :domains, :redirect
    add_column :domains, :redirect, :boolean
  end
end
