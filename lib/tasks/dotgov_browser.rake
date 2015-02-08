namespace :dotgov_browser do
  task crawl: :environment do
    Domain.all.order("updated_at asc")[0...5].each do |domain|
      puts "Inspecting #{domain.host}"
      inspector = SiteInspector.new(domain.host)
      inspector.to_hash.each do |field, value|
        domain.send("#{field}=", value) if domain.respond_to?("#{field}=")
      end
      domain.save!
    end
  end
end
