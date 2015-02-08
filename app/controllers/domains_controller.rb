class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  # GET /domains.json
  def index
    query = {}
    Domain::BOOLEANS.each do |field|
      next unless params[field]
      query[field] = !!(params[field] == "true")
    end
    @domains = Domain.where(query).order("host asc").page(params[:page])
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
