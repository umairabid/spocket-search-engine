require 'product_search_service'

class HomeController < ApplicationController

  before_action :set_params, only: [:index]

  def index
    @products = Product.all
    @countries = Country.all.map {|c| c.name}
    apply_filters
    apply_sort
    @products = @products.page(@params[:page]).per(10)
  end

  private

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

  def apply_filters
    @products = @products.search_query(@params[:p_q]) if @params[:p_q] != ''
    @products = @products.where('country IN (?)', @params[:sc]) if @params[:sc].count > 0
    @products = @products.where('price >= ?', @params[:min]) if @params[:min].to_i > 0
    @products = @products.where('price <= ?', @params[:max]) if @params[:max].to_i > 0
  end

  def apply_sort
    @products = @products.order(price: :desc) if @params[:sort_by] == 'high_price'
    @products = @products.order(price: :asc) if @params[:sort_by] == 'low_price'
  end
end
