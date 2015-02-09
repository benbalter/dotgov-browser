module DomainsHelper
  def row_for(field, label=nil)
    render( partial: 'domains/row', locals: { domain: @domain, field: field, label: label } )
  end
end
