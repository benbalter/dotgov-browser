module DomainsHelper
  def row_for(field, label=nil)
    render( partial: 'domains/row', locals: { domain: @domain, field: field, label: label } )
  end

  def format_key(string)
    abbvs = %w[www https hsts url dnssec ipv6 cdn xml txt ip xss dns uri]
    string.to_s.humanize.gsub(/\b(#{abbvs.join("|")})\b/i) { "#{$1}".upcase }
  end
end
