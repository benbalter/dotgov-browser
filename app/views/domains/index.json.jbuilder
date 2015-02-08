json.array!(@domains) do |domain|
  json.extract! domain, :id, :host
  json.url domain_url(domain, format: :json)
end
