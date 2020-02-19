class HomeController < ApplicationController

  before_action :set_service, :set_params, only: [:index]

  def index
    @products = @service.search_products @params
    @countries = Country.all.map {|c| c.name}
  end

  private

  def set_service
    @service = ProductsService.new
  end

  def set_params
    @params = {
        :sc => params[:sc] || [],
        :sort_by => params[:sort_by] || 'relevance',
        :page => params[:page] || 1,
        :p_q => params[:p_q] || '',
        :min => params[:min] || '',
        :max => params[:max] || ''
    }
  end
end
