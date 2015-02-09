class CreateContentDeliveryNetworks < ActiveRecord::Migration
  def change
    create_table :content_delivery_networks do |t|
      t.string :name

      t.timestamps null: false
    end
    
    change_table :domains do |t|
      t.belongs_to :content_delivery_network, index: true
    end
  end
end
