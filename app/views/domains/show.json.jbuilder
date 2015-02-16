json.extract! @domain, :id, :host, :updated_at
Domain::BOOLEANS.each do |field|
  json.set! field, @domain.send(field)
  json.set! :cms, @domain.cms
  json.set! :cdn, @domain.cdn
  json.set! :analytics, @domain.analytics
  json.set! :javascript, @domain.javascript
end
