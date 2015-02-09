namespace :dotgov_browser do
  task crawl: :environment do
    Domain.all.order("updated_at asc").each do |d|
      puts "Inspecting #{domain.host}"
      domain.crawl!
    end
  end
end
