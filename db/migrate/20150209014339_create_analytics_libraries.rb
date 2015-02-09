class CreateAnalyticsProviders < ActiveRecord::Migration
  def change
    create_table :analytics_providers do |t|
      t.string :name
      t.timestamps null: false
    end
  end

  create_table :analytics_providers_domains, id: false do |t|
      t.belongs_to :analytics_providers, index: true
      t.belongs_to :domain, index: true
    end
end
