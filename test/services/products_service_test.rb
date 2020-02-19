Rails.application.load_tasks
Rake::Task["load_products"].execute

class ProductsServiceTest < ActiveSupport::TestCase
  setup do
    @service = ProductsService.new
  end

  test "it correctly applied high_price sort" do
    params = default_params
    params[:sort_by] = 'high_price'
    products = @service.search_products params
    last_price = products[0].price
    products.drop(1)
    is_sorted = true
    products.each do |p|
      if p.price > last_price
        is_sorted = false
        break
      end
      last_price = p.price
    end
    assert(is_sorted)
  end

  test "it correctly applied low_price sort" do
    params = default_params
    params[:sort_by] = 'low_price'
    products = @service.search_products params
    last_price = products[0].price
    products.drop(1)
    is_sorted = true
    products.each do |p|
      if p.price < last_price
        is_sorted = false
        break
      end
      last_price = p.price
    end
    assert(is_sorted)
  end

  test "it correctly applied search query and relevance sort" do
    params = default_params
    params[:p_q] = 'silver'
    products = @service.search_products params
    assert(products.count == 2)
    assert(products[0].title.downcase.include? 'silver')
    assert_not(products[1].title.downcase.include? 'silver')
  end

  test "it correctly filters by country" do
    params = default_params
    params[:sc] = ['Canada']
    products = @service.search_products params
    assert(products.all {|c| c.country == 'Canada'})
  end

  test "it correctly filters by multiple countries" do
    params = default_params
    params[:sc] = ['Canada', 'Germany']
    products = @service.search_products params
    assert(products.all {|c| c.country == 'Canada' or c.country == 'Germany'})
  end

  test "it correctly filters by min_price" do
    params = default_params
    params[:min] = '12'
    products = @service.search_products params
    assert(products.all {|c| c.price >= 12})
  end

  test "it correctly filters by max_price" do
    params = default_params
    params[:min] = '9'
    params[:max] = '12'
    products = @service.search_products params
    assert(products.all {|c| c.price <= 12 and c.price >= 9})
  end

  private

  def default_params
    {
        :sc => [],
        :sort_by => 'relevance',
        :page => 1,
        :p_q => '',
        :min => '',
        :max => ''
    }
  end
end
