require 'rubygems'
require 'nokogiri'
require 'open-uri'



# NOTE: un programme qui va récupérer le cours de toutes les cryptomonnaies, et les enregistrer bien proprement dans une array de hashs.

# méthode globales
@price = []
@monnaie_name = []
@taux = []
@crypto = []
def stock_market_price
  for i in 0..24
    crypto
    array_to_hash
    puts @crypto
    sleep 3600
  end
end
# méthode pour récupérer le cour de la monnaie, son nom et son changement de taux horaire
def crypto  
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all"))
  page.xpath('//a[@class = "price"]').each do |node|
    @price << node.text
  end
  page.xpath('//td[@data-timespan="1h"]').each do |node| 
    @taux << node.text
  end
  page.xpath('//a[@class = "currency-name-container link-secondary"]').each do |node|
    @monnaie_name << node.text
  end    
end
# méthode pour obtenir un hash
def array_to_hash
  size = @price.size - 1
  for i in 0..size
    @crypto[i] = {"name" => @monnaie_name[i], "prix" => @price[i], "taux 1h" => @taux[i] }
  end
    
end

# affichage du hash
puts stock_market_price

