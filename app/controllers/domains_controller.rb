class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  # GET /domains.json
  def index
    @query = {}

    [ContentDeliveryNetwork, ContentManagementSystem, JavascriptLibrary].each do |klass|
      sym = klass::SHORT_NAME
      @query[klass.model_name.singular.to_sym] = klass.find_by(:name => params[sym]) if params[sym]
    end

    if params[:agency]
      agency = Agency.find_by :slug => params[:agency]
      @query[:agency] = agency
    end

    [:ip, :hostname, :server].each do |field|
      @query[field] = params[field] if params[field]
    end

    Domain::BOOLEANS.each do |field|
      next unless params[field]
      @query[field] = !!(params[field] == "true")
    end
    @domains = Domain.where(@query).order("host asc").page(params[:page])
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:host)
    end
end
