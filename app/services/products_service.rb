class ProductsService
  def search_products(params)
    products = Product.all
    products = apply_filters products, params
    products = apply_sort products, params
    products.page(params[:page]).per(10)
  end

  def apply_filters(products, params)
    products = products.search_query(params[:p_q]) if params[:p_q] != ''
    products = products.where('country IN (?)', params[:sc]) if params[:sc].count > 0
    products = products.where('price >= ?', params[:min]) if params[:min].to_i > 0
    products = products.where('price <= ?', params[:max]) if params[:max].to_i > 0
    products
  end

  def apply_sort(products, params)
    products = products.order(price: :desc) if params[:sort_by] == 'high_price'
    products = products.order(price: :asc) if params[:sort_by] == 'low_price'
    products
  end
end
