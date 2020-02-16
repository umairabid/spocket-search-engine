desc 'Load products from given file'
task :load_products, [:filename] => [:environment] do |t, args|
  args.with_defaults(:filename => "SpocketProducts.json")
  path = Rails.root.join "data", args[:filename]
  file = File.open path
  data = JSON.load file
  if data.length > 0
    Product.delete_all
    data.each do |product|
      Product.create(product)
    end
    file.close
    puts "Products have been loaded successfully"
  end
end
