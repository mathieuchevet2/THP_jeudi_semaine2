require 'rubygems'
require 'nokogiri'
require 'open-uri'

@arr_url = []
@arr_townhal = []
@arr_mail = []
@townhal_mail = []
#methode aui retourne l'adresse mail de la mairie de vaureal
def get_the_email_of_a_townhal_from_its_webpage(url)   
  page_townhal(url)
end
#méthode qui retourne le tableau de hash de toutes les villes du val d'oise avec leurs mails
def get_all_the_urls_of_val_doise_townhalls(url, url2)
  url_townhal(url, url2)
  townhal_mail
  puts @townhal_mail
end
#méthode qui retourne un tableau avec les url de chaque mairie du val d'oise, un tableau avec leurs nom et qui fait appel à la méthode page_townhal en lui envoyant les url des mairies en parametre
def url_townhal(url, url2)  
  page = Nokogiri::HTML(open("#{url2}"))
  page.xpath('//a[@class = "lientxt"]').each do |node|
    a = node.values
    b = node.text
    @arr_townhal << b
    url_full = a[1].delete_prefix('.')
    url_full = url + url_full
    page_townhal(url_full)
    @arr_url << url_full
  end
end
#méthode qui retourne un tableau de tous les mails des mairies
def page_townhal(url)
  c =[]
  begin
    page3 = Nokogiri::HTML(open("#{url}"))   
    page3.xpath('//td').each do |node|
      c << node.text
    end
    @arr_mail << c[7]
  rescue 
puts 'erreur'
  end
end
#méthode qui transforme les tableaux de mail et de nom de mairies en tableau de hash
def townhal_mail
  size = @arr_mail.size - 1
  for i in 0..size
    @townhal_mail[i] = {"name" => @arr_townhal[i], "email" => @arr_mail[i]}
  end
end

puts get_the_email_of_a_townhal_from_its_webpage('http://www.annuaire-des-mairies.com/95/vaureal.html')
puts get_all_the_urls_of_val_doise_townhalls('http://annuaire-des-mairies.com','http://annuaire-des-mairies.com/val-d-oise.html')




