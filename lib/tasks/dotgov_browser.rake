namespace :dotgov_browser do
  task crawl: :environment do
    Domain.all.order("updated_at asc").each do |domain|
      puts "Inspecting #{domain.host}"
      domain.crawl!
    end
  end
end
