desc 'Load products from given file'
task :load_products, [:filename] => [:environment] do |t, args|
  args.with_defaults(:filename => "SpocketProducts.json")
  path = Rails.root.join "data", args[:filename]
  file = File.open path
  data = JSON.load file
  if data.length > 0
    Product.delete_all
    Country.delete_all
    countries = []
    data.each do |product|
      countries.push(product["country"])
      Product.create(product)
    end
    countries.uniq.each {|c| Country.create({name: c})}
    file.close
    puts "Products have been loaded successfully"
  end
end
