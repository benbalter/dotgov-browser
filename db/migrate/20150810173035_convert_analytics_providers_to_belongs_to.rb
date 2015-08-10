class ConvertAnalyticsProvidersToBelongsTo < ActiveRecord::Migration
  def change
    drop_table :analytics_providers_domains
    add_column :domains, :analytics_provider_id, :integer
    add_index :domains, :analytics_provider_id
  end
end
